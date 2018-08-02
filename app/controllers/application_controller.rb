  class ApplicationController < ActionController::Base
  before_action :blocked?

  def not_found
    redirect_to root_path, alert: 'Website does not exist'
  end

  private

  def blocked?
    if current_user.present? && current_user.blocked?
      sign_out current_user
      redirect_to new_user_session_path, alert: 'Account suspended'
    end
  end
end
