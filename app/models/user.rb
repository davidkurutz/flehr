class User < ActiveRecord::Base
  def conversations
    Conversation.where("sender_id = ? OR recipient_id = ?", self.id, self.id )
  end
  validates_presence_of :username
end