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

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    @tag = Tag.find(params[:id])
    return unless @tag.update(tag_params)
    # ?
    redirect_to tags_path, notice: 'Tag edited'
  end

  private

  def authorize_admin
    redirect_to root_path, alert: 'Permissions denied' unless
     current_user.is_admin?
  end

  def tag_params
    params.require(:tag).permit(:name)
  end
end
