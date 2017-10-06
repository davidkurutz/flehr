module Api
  module V1
    class MessagesController < ApplicationController
      def create
        @conversation = Conversation.find_by(id: params[:conversation_id])
        @message = @conversation.messages.build(message_params)

        if @message.save
          json_response(@message)
        else
          
        end
      end

      private

      def message_params
        params['sender_id'] = params['user_id']
        params.permit(:body, :sender_id, :conversation_id)
      end
    end   
  end
end

