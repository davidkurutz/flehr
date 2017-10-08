module ApplicationCable
  class Connection < ActionCable::Connection::Base
    def connect
      the_current_user = current_user
    end

    def current_user
      @current_user ||= User.find_by(id: cookies[:user_id])
    end
  end
end
