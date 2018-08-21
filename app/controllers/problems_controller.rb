class ProblemsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create add_contributor destroy edit update send_help_request]

  def index
    @problems = Problem.all.paginate(per_page: 5, page: params[:page])
  end

  def check_projects
    Gitlab.projects(visibility: 'public', owned: true, simple: true)
  end

  def new
    @problem = Problem.new
    @all_users_mapped = User.all.reject { |user| user == current_user || user.is_admin }
    git = check_projects
    @projects = git.map { |p| [p.path] }
  end

  def edit
    @problem = Problem.find(params[:id])
    is_allowed = @problem.creator_id != current_user.id && !current_user.is_admin
    redirect_to root_path, notice: 'You are not able to edit this problem!' if is_allowed
    @all_users_mapped = User.all.reject { |user| user == current_user || user.is_admin }
    git = Gitlab.projects(visibility: 'public', owned: true, simple: true)
    @projects = git.map { |p| [p.path] }
  end

  def update
    @problem = Problem.find(params[:id])
    if @problem.update(problem_params)
      redirect_to problems_url, notice: 'Problem has been updated'
    else
      render :edit
    end
  end

  def create
    @problem = Problem.new(problem_params.merge(creator_id: current_user.id))
    @all_users_mapped = User.all.reject { |user| user == current_user || user.is_admin }
    git = check_projects
    @projects = git.map { |p| [p.path] }
    if @problem.save
      redirect_to root_path, notice: 'You created post successfully!'
    else
      render :new
    end
  end

  def add_contributor
    @all_users_mapped = User.all.map { |p| [p.full_name, p.id] }
  end

  def search_problems
    begin
      problems_loc = create_searching_service.call
    rescue ArgumentError => e
      redirect_to root_path, alert: e.message
      return
    end
    @problems = problems_loc.paginate(per_page: 5, page: params[:page])
  end

  def filter_search_results
    # we can assume that previous
    # search was successful
    problems_loc = create_searching_service.call
    filtered_results = create_filtering_service(problems_loc).call
    @problems = filtered_results.paginate(per_page: 5, page: params[:page])
    render 'search_problems'
  end

  def show
    @problem = Problem.find(params[:id])
    @comment = Comment.new
    @is_current_contributor = @problem.current_user_contributor?(current_user)
    @is_creator = @problem.creator?(current_user)
    @comments = Comment.where(problem_id: params[:id]).order(created_at: :desc)
    @users = User.all
    @comment_errors = params[:errors] || {}
  end

  def destroy
    @problem = Problem.find(params[:id])
    @problem.destroy
    redirect_to root_path, alert: 'Your problem was successfully destroyed!'
  end

  def send_help_request
    successful = true
    problem = Problem.find(params[:id])
    creator = User.find(problem.creator_id)
    HelpProblemMailer.help_request_email(problem, current_user).deliver_now
    begin
      create_slack_service(
        creator.email,
        problem.title,
        "#{current_user.name} #{current_user.surname}",
        problem_url(id: problem.id)
      ).call
    rescue ArgumentError => e
      flash[:alert] = e.message
      # strange construction
      successful = false
    end
    # change this for more efficient way ?
    redirect_to problem_path(id: params[:id]), notice: 'Email request was sent' unless successful
    redirect_to problem_path(id: params[:id]), notice: 'Request was sent' if successful
  end

  private

  # delegaate this methods to factory class?
  def create_searching_service
    SearchingService.new(
      advanced_search_on: params[:advanced_search_on],
      lookup: params[:lookup],
      title_on: params[:title_on],
      content_on: params[:content_on],
      reference_on: params[:reference_on],
      tag_names: params[:tag_names]
    )
  end

  def create_filtering_service(problems_collection)
    FilteringService.new(
      collection: problems_collection,
      order: params[:order_by]
    )
  end

  def create_slack_service(mail, problem_title, full_name, url)
    SlackService.new(mail, problem_title, full_name, url)
  end

  def problem_params
    params.require(:problem).permit(
      :title,
      :content,
      :reference_list,
      :advanced_search_on,
      :content_on,
      :title_on,
      :status,
      :project,
      tag_ids: [],
      user_ids: [],
      tag_names: [],
      problem_users_attributes: %i[id user_id]
    )
  end
end
