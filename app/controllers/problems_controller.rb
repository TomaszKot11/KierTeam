class ProblemsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create add_contributor]

  def index
    @problems = Problem.all
  end

  def new
    @problem = Problem.new
    @all_users_mapped = User.all.reject { |user| user == current_user }
  end

  def create
    @problem = Problem.new(problem_params.merge(creator_id: current_user.id))
    @all_users_mapped = User.all.map { |p| [p.full_name, p.id] }

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
    query = params[:lookup]
    redirect_to root_path, alert: 'Searching query should not be blank!' if query.blank?
    @problems = Problem.where('title LIKE ? OR content LIKE ?', "%#{@query}%", "%#{@query}%").
      paginate(per_page: 5, page: params[:page])
    # for advance searching
   # @problems = @problems.where('created_at > ?', params[:date_from]) if params[:date_from]
   # we can as well store ids but it will cause multiple queries to db
    params[:tag_names].each do |tag_name|
       # make query for tag_names here
    end

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
      tag_ids: [],
      user_ids: [],
      tag_names: [],
      problem_users_attributes: %i[id user_id]
    )
  end
end
