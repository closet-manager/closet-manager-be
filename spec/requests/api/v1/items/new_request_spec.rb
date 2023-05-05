require 'rails_helper'

describe 'POST /users/:id/items' do
  describe 'if a user exists and the image is not included' do
    it 'create an item and attach a default image' do
      user = create(:user)

      headers = { "CONTENT_TYPE": "application/json"}
      item_params = {
                      "user_id": user.id,
                      "season": "all_season",
                      "clothing_type": "shoes",
                      "color": "black",
                      "size": "7",
                      "image": nil,
                      "notes": "testing header"
                      # "favorite": true
                    }

      expect(Item.count).to eq(0)

      post "/api/v1/users/#{user.id}/items", headers: headers, params: JSON.generate(item_params)

      item_response = JSON.parse(response.body, symbolize_names: true)

      expect(Item.count).to eq(1)
      expect(response).to be_successful
      expect(response.status).to eq(201)

      expect(item_response).to have_key(:data)
      expect(item_response[:data]).to be_a(Hash)

      expect(item_response[:data]).to have_key(:id)
      expect(item_response[:data][:id]).to be_a(String)

      expect(item_response[:data]).to have_key(:type)
      expect(item_response[:data][:type]).to be_a(String)

      expect(item_response[:data]).to have_key(:attributes)
      expect(item_response[:data][:attributes]).to be_a(Hash)

      expect(item_response[:data][:attributes]).to have_key(:user_id)
      expect(item_response[:data][:attributes][:user_id]).to be_a(Integer)
      
      expect(item_response[:data][:attributes]).to have_key(:season)
      expect(item_response[:data][:attributes][:season]).to be_a(String)
      
      expect(item_response[:data][:attributes]).to have_key(:clothing_type)
      expect(item_response[:data][:attributes][:clothing_type]).to be_a(String)

      expect(item_response[:data][:attributes]).to have_key(:color)
      expect(item_response[:data][:attributes][:color]).to be_a(String)

      expect(item_response[:data][:attributes]).to have_key(:size)
      expect(item_response[:data][:attributes][:size]).to be_a(String)

      expect(item_response[:data][:attributes]).to have_key(:image_url)
      expect(item_response[:data][:attributes][:image_url]).to be_a(String)

      expect(item_response[:data][:attributes]).to have_key(:notes)
      expect(item_response[:data][:attributes][:notes]).to be_a(String)

      # expect(item_response[:data][:attributes]).to have_key(:favorite)
      # expect(item_response[:data][:attributes][:favorite]).to be_a(Boolean)
    end
  end

  describe 'if a user does not exists' do
    it 'returns an error message' do

      headers = { "CONTENT_TYPE": "application/json"}
      item_params = {
                      "user_id": 1,
                      "season": "all_season",
                      "clothing_type": "shoes",
                      "color": "black",
                      "size": "7",
                      "image": nil,
                      "notes": "testing header"
                    }

      expect(Item.count).to eq(0)

      post "/api/v1/users/1/items", headers: headers, params: JSON.generate(item_params)

      item_response = JSON.parse(response.body, symbolize_names: true)

      expect(Item.count).to eq(0)
      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      expect(item_response).to have_key(:error)
      expect(item_response[:error]).to be_a(Array)

      expect(item_response[:error][0]).to have_key(:title)
      expect(item_response[:error][0][:title]).to be_a(String)

      expect(item_response[:error][0]).to have_key(:status)
      expect(item_response[:error][0][:status]).to be_a(String)
    end
  end

  describe 'if empty strings are passed in' do
    it 'returns an error message' do

      user = create(:user)

      headers = { "CONTENT_TYPE": "application/json"}
      item_params = {
                      "user_id": user.id,
                      "season": "",
                      "clothing_type": "shoes",
                      "color": "black",
                      "size": "7",
                      "image": nil,
                      "notes": "testing header"
                    }

      expect(Item.count).to eq(0)

      post "/api/v1/users/#{user.id}/items", headers: headers, params: JSON.generate(item_params)

      item_response = JSON.parse(response.body, symbolize_names: true)

      expect(Item.count).to eq(0)
      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      expect(item_response).to have_key(:message)
      expect(item_response[:message]).to be_a(String)
      expect(item_response[:message]).to eq("Please ensure no empty strings are passed in.")
    end
  end
end