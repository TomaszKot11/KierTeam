class ApplicationController < ActionController::Base
  before_action :blocked?

  def not_found
    redirect_to root_path, alert: 'Website does not exist'
  end

  private

  def blocked?
    # rubocop
    sign_out current_user if current_user.present? && current_user.blocked?
    redirect_to new_user_session_path, alert: 'Account suspended' if current_user.present? && current_user.blocked?
  end
end
