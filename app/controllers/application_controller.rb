class ApplicationController < ActionController::Base
  include SessionsHelper
  
  private

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end

  def require_admin_logged_in
    unless logged_in? && current_user.is_admin && is_for_admin?
      redirect_to login_url
    end
  end
end
