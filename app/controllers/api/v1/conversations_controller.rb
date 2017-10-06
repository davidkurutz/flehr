module Api
  module V1
    class ConversationsController < ApplicationController
      def index
        user = User.find(params[:user_id])
        conversations = Conversation.involving(user)
        json_response(conversations.as_json(include: [:recipient, :sender]))
      end

      def create
        conversation = Conversation.create!(convo_params)
        json_response(conversation, :created)
      end

      def show
        conversation = Conversation.find(params[:id])
        json_response(conversation.as_json(include: [:messages, :recipient, :sender]))
      end

      private

      def convo_params
        params.permit(:sender_id, :recipient_id)
      end
    end
  end
end
