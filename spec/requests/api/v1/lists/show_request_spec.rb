require 'rails_helper'

describe 'Get /users/:id/lists/:id' do
  context 'if the user and list exist' do
    it 'returns a list from the db' do
      user = create(:user)

      list = List.create(name: "Donation", user_id: user.id)

      get "/api/v1/users/#{user.id}/lists/#{list.id}"

      list_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(list_response).to have_key(:data)
      expect(list_response[:data]).to be_a(Hash)
      expect(list_response[:data]).to have_key(:id)
      expect(list_response[:data][:id]).to be_a(String)

      expect(list_response[:data]).to have_key(:type)
      expect(list_response[:data][:type]).to be_a(String)
      
      expect(list_response[:data]).to have_key(:attributes)
      expect(list_response[:data][:attributes]).to be_a(Hash)

      expect(list_response[:data][:attributes]).to have_key(:name)
      expect(list_response[:data][:attributes][:name]).to be_a(String)

      expect(list_response[:data][:attributes]).to have_key(:user_id)
      expect(list_response[:data][:attributes][:user_id]).to be_a(Integer)

      expect(list_response[:data][:attributes]).to have_key(:items)
      expect(list_response[:data][:attributes][:items]).to be_a(Array)
    end
  end

  context 'if the list does not exist' do
    it 'returns a list from the db' do
      user = create(:user)

      get "/api/v1/users/#{user.id}/lists/#{1}"

      list_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      expect(list_response).to have_key(:error)
      expect(list_response[:error]).to be_a(Array)
      expect(list_response[:error][0]).to have_key(:title)
      expect(list_response[:error][0][:title]).to be_a(String)

      expect(list_response[:error][0]).to have_key(:status)
      expect(list_response[:error][0][:status]).to be_a(String)
    end
  end
end