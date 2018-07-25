class ProblemsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create add_contributor]

  def index
    @problems = Problem.all
  end

  def new
    @problem = Problem.new
    @all_users_mapped = User.all.reject { |user| user == current_user }
  end

  def edit
    @problem = Problem.find(params[:id])
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
    query = params[:lookup]
    redirect_to root_path, alert: 'Searching query should not be blank!' if query.blank?
    @problems = Problem.where('title LIKE ? OR content LIKE ?', "%#{query}%", "%#{query}%").
      paginate(per_page: 5, page: params[:page])
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
      :status,
      tag_ids: [],
      user_ids: [],
      problem_users_attributes: %i[id user_id]
    )
  end
end
