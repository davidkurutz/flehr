class Conversation < ActiveRecord::Base
  before_validation :create_guid

  belongs_to :sender, foreign_key: :sender_id, class_name: 'User'
  belongs_to :recipient, foreign_key: :recipient_id, class_name: 'User'

  has_many :messages, dependent: :destroy

  validate :sender_and_recipient_are_different
  validates_uniqueness_of :guid

  def create_guid
    return unless sender_id && recipient_id
    self.guid = [sender_id, recipient_id].sort.join("-")
  end

  def sender_and_recipient_are_different
    if sender_id == recipient_id
      errors.add(:sender_id, 'must be different from recipient_id')
      errors.add(:recipient_id, 'must be different from sender_id')
    end
  end
end
