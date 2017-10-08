class Message < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :user, foreign_key: "sender_id"

  validates_presence_of :body, :conversation_id, :sender_id
  validates :body, length: { minimum: 1 }
end