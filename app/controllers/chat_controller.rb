class ChatController < ApplicationController
  before_action :require_user
  def index
    @user_id = @current_user.id
    @username = @current_user.username
  end
end