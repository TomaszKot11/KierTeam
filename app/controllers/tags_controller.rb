class TagsController < ApplicationController
  before_action :authenticate_user!, only: %i[index create destroy]

  def index
    @tags = Tag.all
    @tag = Tag.new
  end

  def create
    @tags = Tag.all
    @tag = Tag.new(tag_params)
    @tag.save

    # respond_to do |format|
    #   format.html { render nothing: true }
    # end

    # respond_to do |format|
    #   format.js
    #   #format.html { render partial: 'tags/partials/tag', locals: { tab: @tab } }
    #   format.html { render :index }
    # end
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end
end
