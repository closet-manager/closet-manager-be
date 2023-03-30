require 'rails_helper'

describe 'POST /users/:id/lists' do
  context 'if the user exists' do
    it 'creates a new list' do
      user = (create(:user))

      list_params = { name: "Goodwill" }
      headers = { "CONTENT_TYPE": "application/json"}

      expect(List.count).to eq(0)

      post "/api/v1/users/#{user.id}/lists", headers: headers, params: JSON.generate(list: list_params)
      
      list_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(201)
      expect(List.count).to eq(1)

      expect(list_response).to have_key(:data)
      expect(list_response[:data]).to be_a(Hash)

      expect(list_response[:data]).to have_key(:id)
      expect(list_response[:data][:id]).to be_a(String)
      
      expect(list_response[:data]).to have_key(:type)
      expect(list_response[:data][:id]).to be_a(String)

      expect(list_response[:data]).to have_key(:attributes)
      expect(list_response[:data][:id]).to be_a(String)

      expect(list_response[:data][:attributes]).to have_key(:name)
      expect(list_response[:data][:attributes][:name]).to be_a(String)

      expect(list_response[:data][:attributes]).to have_key(:user_id)
      expect(list_response[:data][:attributes][:user_id]).to be_a(Integer)

      expect(list_response[:data][:attributes]).to have_key(:items)
      expect(list_response[:data][:attributes][:items]).to be_a(Array)
    end

    it 'returns an error if the params are missing' do
      user = create(:user)

      list_params = { name: "" }
      headers = { "CONTENT_TYPE": "application/json"}

      expect(List.count).to eq(0)

      post "/api/v1/users/#{user.id}/lists", headers: headers, params: JSON.generate(list: list_params)
      
      list_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(List.count).to eq(0)

      expect(list_response).to have_key(:error)
      expect(list_response[:error]).to be_a(Array)

      expect(list_response[:error][0]).to have_key(:title)
      expect(list_response[:error][0][:title]).to be_a(String)
      
      expect(list_response[:error][0]).to have_key(:status)
      expect(list_response[:error][0][:status]).to be_a(String)
    end
  end
end