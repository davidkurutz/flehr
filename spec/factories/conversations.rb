FactoryGirl.define do
  factory :conversation do
    sender_id 1
    recipient_id 2
  end

  factory :repeated_conversation, class: Conversation do
    sender_id 3
    recipient_id 4
  end
end