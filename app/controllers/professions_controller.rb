class ProfessionsController < ApplicationController
  before_action :authenticate_user!, :authorize_admin

  def index
    @professions = Profession.all
    @profession = Profession.new
  end

  def create
    @professions = Profession.all
    @profession = Profession.new(profession_params)
    @profession.save
  end

  def destroy
    @profession = Profession.find(params[:id])
    @profession.destroy
  end

  def edit
    @profession = Profession.find(params[:id])
  end

  def update
    @profession = Profession.find(params[:id])
    return unless @profession.update(profession_params)
    redirect_to professions_path, notice: 'Profession edited'
  end

  def authorize_admin
    redirect_to root_path, alert: 'Permissions denied' unless
     current_user.is_admin?
  end

  def profession_params
    params.require(:profession).permit(:name)
  end
end
