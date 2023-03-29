require 'rails_helper'

describe 'GET /users/:id/lists' do
  context 'if the user exists' do
    it 'returns a users lists' do
      user = create(:user)

      list1 = List.create!(name: "Summer Vacay", user_id: user.id)
      list2 = List.create!(name: "Gym Stuff", user_id: user.id)
      list3 = List.create!(name: "GoodWill", user_id: user.id)

      get "/api/v1/users/#{user.id}/lists"

      list_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(list_response).to have_key(:data)
      expect(list_response[:data]).to be_a(Array)

      list_response[:data].each do |list|
        expect(list).to have_key(:id)
        expect(list).to have_key(:type)
        expect(list).to have_key(:attributes)
        expect(list[:attributes]).to have_key(:name)
        expect(list[:attributes][:name]).to be_a(String)

        expect(list[:attributes]).to have_key(:user_id)
        expect(list[:attributes][:user_id]).to be_a(Integer)
        
        expect(list[:attributes]).to have_key(:items)
        expect(list[:attributes][:items]).to be_a(Array)
      end
    end

    it 'returns an empty array if the user does not have any lists' do
      user = create(:user)

      get "/api/v1/users/#{user.id}/lists"

      list_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(list_response).to have_key(:data)
      expect(list_response[:data]).to be_a(Array)
      expect(list_response[:data]).to eq([])
    end
  end
end