require 'rails_helper'

RSpec.describe 'Messages API', type: :request do
  let!(:users) { create_list(:user, 4)}
  
  describe 'GET /api/v1/users/:user_id/conversations' do
    let!(:conversations) { create_list(:conversation, 1)}
    
    before { get '/api/v1/users/1/conversations' }

    it 'returns conversations' do
      expect(json).not_to be_empty
      expect(json.size).to eq(1)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /api/v1/users/:user_id/conversations/:conversation_id' do
    let!(:conversations) { create_list(:conversation, 1)}
    let(:conversation_id) { conversations.first.id }
    before { get "/api/v1/users/1/conversations/#{conversation_id}"}

    context 'when the record exists' do
      it 'returns the conversation' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(conversation_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:conversation_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Conversation/)
      end
    end
  end

  describe 'POST /api/v1/conversations' do
    let(:valid_attributes) { { sender_id: 1, recipient_id: 2 }}

    context 'when the request is valid' do
      before { post '/api/v1/users/1/conversations', params: valid_attributes }

      it 'creates a conversation' do
        expect(json['sender_id']).to eq(1)
        expect(json['recipient_id']).to eq(2)
      end

      it 'returns a 201 status code' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/users/1/conversations', params: {}}
      it 'returns a 422 status code' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: Sender must exist, Recipient must exist/)
      end
    end
  end
end