FactoryGirl.define do
  factory :message do
    body { Faker::Coffee.notes }
    conversation_id nil
  end
end