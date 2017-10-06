FactoryGirl.define do
  factory :user do
    username { Faker::Coffee.blend_name }
  end
end