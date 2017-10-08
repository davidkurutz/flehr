require 'rails_helper'

RSpec.describe 'Messages API', type: :request do
  let!(:users) { create_list(:user, 4)}
  
  describe 'GET /api/v1/users/:user_id/conversations' do
    let!(:conversations) { create_list(:conversation, 1)}
    
    before { get '/api/v1/users/1/conversations' }

    it 'returns conversations' do
      expect(json['data']).not_to be_empty
      expect(json['data'].size).to eq(1)
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
        expect(json['data']).not_to be_empty
        expect(json['data']['id']).to eq(conversation_id)
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
    let(:valid_attributes) { { recipient_id: 2 }}
    let!(:repeated_attributes) { { recipient_id: 4 }}
    let!(:repeated_convo) { create_list(:repeated_conversation, 1)}

    context 'when the request is valid' do
      before { post '/api/v1/users/1/conversations', params: valid_attributes }

      it 'creates a conversation' do
        expect(json['data']['sender_id']).to eq(1)
        expect(json['data']['recipient_id']).to eq(2)
      end

      it 'returns a 201 status code' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is missing parameters' do
      before { post '/api/v1/users/1/conversations', params: {}}
      it 'returns a 422 status code' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: Recipient must exist/)
      end
    end

    context 'when sender and recipient are the same' do
      before { post '/api/v1/users/3/conversations', params: {recipient_id: 3}}

      it 'returns a 422 status code' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: Sender must be different from recipient_id, Recipient must be different from sender_id/)
      end
    end

    context 'when the conversation already exists' do
      before { post '/api/v1/users/3/conversations', params: {recipient_id: 4}}
      it 'returns a 422 status code' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: Guid has already been taken/)
      end
    end

    context 'when the conversation already exists but sender/recipient are reversed' do
      before { post '/api/v1/users/4/conversations', params: { recipient_id: 3 } }
      it 'returns a 422 status code' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: Guid has already been taken/)
      end
    end
  end
end