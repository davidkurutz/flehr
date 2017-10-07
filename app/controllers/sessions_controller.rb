class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by username: params[:username]

    unless user
      user = User.create(username: params[:username])
    end
    
    login_user!(user)
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def login_user!(user)
    session[:user_id] = user.id
    redirect_to root_path
  end
end