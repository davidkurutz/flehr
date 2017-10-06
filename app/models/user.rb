class User < ActiveRecord::Base
  has_many :conversations, :foreign_key => :sender_id
  validates_presence_of :username
end