class ApplicationController < ActionController::Base
  before_action :blocked?

  private

  def blocked?
    if current_user.present? && current_user.blocked?
      sign_out current_user
      redirect_to new_user_session_path, alert: 'Account suspended'
    end
  end
end
