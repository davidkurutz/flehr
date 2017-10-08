FactoryGirl.define do
  factory :user do
    username { Faker::Name.unique.first_name }
  end

  factory :brock, class: User do
    username 'Brock'
  end
end