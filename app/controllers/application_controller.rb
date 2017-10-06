class ApplicationController < ActionController::Base
  include Response
  include ExceptionHandler
  protect_from_forgery with: :null_session

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:error] = "You must be logged in to do that."
      redirect_to login_path
    end
  end
end
