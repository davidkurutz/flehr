class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by username: params[:username]
    user ||= User.create(username: params[:username])
    login_user!(user)
  end

  def destroy
    session[:user_id] = nil
    cookies[:user_id] = nil
    redirect_to root_path
  end

  private

  def login_user!(user)
    session[:user_id] = user.id
    cookies[:user_id] = user.id
    redirect_to root_path
  end
end
