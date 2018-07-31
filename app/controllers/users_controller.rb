class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin, only: %i[ban destroy]

  def index
    @users = User.all.paginate(per_page: 5, page: params[:page])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
    user_problems = Problem.where(creator_id: params[:id])
    @problems_posted = user_problems.where(status: true)
    @problems_not_posted = user_problems.where(status: false)
    @user_img = @user.avatar.url(:thumb)
  end

  def ban
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_url
    else
      redirect_to users_url, notice: 'Could not perform operation'
    end
  end

  private
  def authorize_admin
    redirect_to root_path, alert: 'Permissions denied' unless
     current_user.is_admin?
  end

  def user_params
    params.require(:user).permit(:blocked)
  end
end
