require 'rails_helper'

RSpec.describe Message, type: :model do
  it { should belong_to(:user)}
  it { should belong_to(:conversation)}
  it { should validate_presence_of(:conversation_id)}
  it { should validate_presence_of(:sender_id)}
  it { should validate_presence_of(:body)}
  it { should validate_length_of(:body)}
end