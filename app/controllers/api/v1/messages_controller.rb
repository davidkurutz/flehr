module Api
  module V1
    class MessagesController < ApplicationController
      def create
        message = Message.new(message_params)

        if message.save!
          room = "MessagesForConversation" + message_params[:conversation_id].to_s
          json = socket_envelope(message.as_json)
          ActionCable.server.broadcast room, json
        end
        json_envelope(message.as_json, :created)
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
