require 'rails_helper'

describe 'POST /users/:id/items' do
  describe 'if the image is not included' do
    xit 'create an item and attach a default image' do
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
    end
  end
end