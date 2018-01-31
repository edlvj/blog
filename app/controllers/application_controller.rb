class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError do
    flash[:alert] = 'Please sign in.'
    redirect_to new_user_session_path
  end
end
