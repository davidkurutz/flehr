class User < ActiveRecord::Base
  def conversations
    Conversation.where("sender_id = ? OR recipient_id = ?", id, id)
  end
  validates_presence_of :username
  validates_uniqueness_of :username
end
