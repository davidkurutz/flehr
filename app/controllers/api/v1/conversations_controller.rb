module Api
  module V1
    class ConversationsController < ApplicationController
      def index
        user = User.find(params[:user_id])
        conversations = user.conversations
        json_envelope(conversations.as_json(include: [:recipient, :sender]))
      end

      def create
        conversation = Conversation.new(convo_params.merge({"sender_id" => params[:user_id]}))

        if conversation.save!
          room = "ConversationsForUser" + "#{convo_params[:recipient_id]}"
          json = socket_envelope(conversation.as_json(include: [:recipient, :sender]))
          ActionCable.server.broadcast room, json
        end

        json_envelope(conversation.as_json(include: [:recipient, :sender]), :created)
      end

      def show
        conversation = Conversation.find(params[:id])
        json_envelope(conversation.as_json(include: [:messages, :recipient, :sender]))
      end

      private

      def convo_params
        params.permit(:recipient_id)
      end
    end
  end
end
