require 'rails_helper'

RSpec.describe 'Messages API', type: :request do
  let!(:users) { create_list(:user, 2)}
  let!(:conversations) {create_list(:conversation, 1)}
  let(:user_id1) { users.first.id }
  let(:user_id2) { users.last.id }

  describe 'POST /api/v1/users/1/conversations/1/messages' do
    context 'when the request is valid' do
      before { post '/api/v1/users/1/conversations/1/messages', params: {body: 'hello there sir'} }

      it 'creates a message' do
        expect(json['data']['body']).to eq('hello there sir')
        expect(json['data']['sender_id']).to eq(1)
        expect(json['data']['conversation_id']).to eq(1)
      end

      it 'returns a 201 status code' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the message body is too short' do
      before { post '/api/v1/users/1/conversations/1/messages', params: {body: ''} }
      it 'returns a 422 status code' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: Body can't be blank, Body is too short/)
      end
    end

    context 'when the message body does not exist' do
      before { post '/api/v1/users/1/conversations/1/messages', params: {} }
      it 'returns a 422 status code' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: Body can't be blank, Body is too short/)
      end
    end
  end
end