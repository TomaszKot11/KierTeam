class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all.paginate(per_page: 5, page: params[:page])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
   # flash[:notice] = 'User was destroyed!'
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
    @problems = Problem.where(creator_id: params[:id]).find_each
    @user_img = @user.avatar.url(:thumb)
  end

end
