module Api
  module V1
    class MessagesController < ApplicationController
      def create
        conversation = Conversation.find_by(id: params[:conversation_id])
        message = conversation.messages.build(message_params)
        message.save
        json_response(message)
      end

      private

      def message_params
        filtered = params.except(:user_id)
        filtered['sender_id'] = params['user_id']
        filtered.permit(:body, :sender_id, :conversation_id)
      end
    end   
  end
end

