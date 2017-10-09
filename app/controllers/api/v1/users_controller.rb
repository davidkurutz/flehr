module Api
  module V1
    class UsersController < ApplicationController
      def index
        users = User.all
        json_envelope(users)
      end

      def create
        user = User.create!(user_params)
        json_envelope(user, :created)
      end

      def show
        user = User.find(params[:id])
        json_envelope(user)
      end

      private

      def user_params
        params.permit(:username)
      end
    end
  end
end
