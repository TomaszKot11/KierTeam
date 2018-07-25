class ProblemsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create add_contributor destroy]

  def index
    @problems = Problem.all
  end

  def new
    @problem = Problem.new
    @all_users_mapped = User.all.reject { |user| user == current_user || user.is_admin == true }
  end

  def edit
    @problem = Problem.find(params[:id])
    @all_users_mapped = User.all.reject { |user| user == current_user || user.is_admin == true }
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
    @all_users_mapped = User.all.map { |p| [p.full_name, p.id] }
    # wtf?
    @problem.status = false
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
    # for only tag searching searching phrase is not necessary
    if params[:advanced_search_on].present?
      @problems = perform_advanced_search.paginate(per_page: 5, page: params[:page])
    else
      is_lookup = params[:lookup].present?
      redirect_to root_path, alert: 'Searching query should not be blank!' unless is_lookup
      @problems = Problem.default_search(params[:lookup]).paginate(per_page: 5, page: params[:page])
    end
  end

  # may be inefficient? - all records?
  # long if not to show all records when
  # none option is specified
  def perform_advanced_search
    is_title = params[:title_on].present?
    is_content = params[:content_on].present?
    is_lookup = params[:lookup].present?

    problems_loc = tag_search_without_query

    if is_content || is_title
      redirect_to root_path, alert: 'Searching query should not be blank!' unless is_lookup
      # content
      problems_loc = problems_loc.content_where(params[:lookup]) if is_content

      # title
      problems_loc = problems_loc.title_where(params[:lookup]) if is_title
    end
    problems_loc
  end

  # Tags search is specific beacuse doesn't need any quey to be present
  def tag_search_without_query
    tag_names = params[:tag_narmes].present?
    problems_loc = Problem.where(nil)
    params[:tag_names].each { |tag_name| problems_loc = problems_loc.tag_where(tag_name) } if tag_names
    problems_loc
  end

  def show
    @problem = Problem.find(params[:id])
    @comment = Comment.new
    @creator_id = @problem.creator.id
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

  private

  def problem_params
    params.require(:problem).permit(
      :title,
      :content,
      :references,
      :advanced_search_on,
      :content_on,
      :title_on,
      :status,
      tag_ids: [],
      user_ids: [],
      tag_names: [],
      problem_users_attributes: %i[id user_id]
    )
  end
end
