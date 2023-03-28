require 'rails_helper'

describe 'GET /users/:id' do
  context 'if the user exists' do
    it 'returns a user from the db' do
      user = create(:user)

      get "/api/v1/users/#{user.id}"

      user_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(user_response).to have_key(:data)
      expect(user_response[:data]).to be_a(Hash)
      expect(user_response[:data]).to have_key(:id)
      expect(user_response[:data][:id]).to be_a(String)

      expect(user_response[:data]).to have_key(:type)
      expect(user_response[:data][:type]).to be_a(String)
      
      expect(user_response[:data]).to have_key(:attributes)
      expect(user_response[:data][:attributes]).to be_a(Hash)

      expect(user_response[:data][:attributes]).to have_key(:first_name)
      expect(user_response[:data][:attributes][:first_name]).to be_a(String)

      expect(user_response[:data][:attributes]).to have_key(:last_name)
      expect(user_response[:data][:attributes][:last_name]).to be_a(String)

      expect(user_response[:data][:attributes]).to have_key(:email)
      expect(user_response[:data][:attributes][:email]).to be_a(String)
    end
  end
end