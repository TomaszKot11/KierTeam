class TagsController < ApplicationController
  before_action :authenticate_user!, :authorize_admin

  def index
    @tags = Tag.all
    @tag = Tag.new
  end

  def create
    @tags = Tag.all
    @tag = Tag.new(tag_params)
    @tag.save
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
  end

  private

  def authorize_admin
    redirect_to root_path, alert: "Permissions denied" unless
     current_user.is_admin?
  end

  def tag_params
    params.require(:tag).permit(:name)
  end
end
