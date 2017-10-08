require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  let!(:users) { create_list(:user, 10)}
  let(:user_id) { users.first.id }

  describe 'GET /api/v1/users' do
    before { get '/api/v1/users' }

    it 'returns users' do
      expect(json['data']).not_to be_empty
      expect(json['data'].size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /api/v1/users/:id' do
    before { get "/api/v1/users/#{user_id}"}

    context 'when the record exists' do
      it 'returns the user' do
        expect(json['data']).not_to be_empty
        expect(json['data']['id'].to_i).to eq(user_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:user_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end
  end

  describe 'POST /api/v1/users' do
    let(:valid_attributes) { { username: 'The Undertaker' }}
    let(:repeated_attributes) { { username: 'Brock' }}
    let!(:brock_lesnar) { create_list(:brock, 1)}
    
    context 'when the request is valid' do
      before { post '/api/v1/users', params: valid_attributes }

      it 'creates a user' do
        expect(json['data']['username']).to eq('The Undertaker')
      end

      it 'returns a 201 status code' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is empty' do
      before { post '/api/v1/users', params: {}}
      it 'returns a 422 status code' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: Username can't be blank/)
      end
    end

    context 'when the username is already taken' do
      before { post '/api/v1/users', params: repeated_attributes }
      it 'returns a 422 status code' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: Username has already been taken/)
      end
    end
  end
end