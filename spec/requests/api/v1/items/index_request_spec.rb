require 'rails_helper'

describe 'GET /users/:id/items' do 
  context 'if the user has items' do 
    it 'returns all items that belong to a user' do 
      user = create(:user)
      user2 = create(:user)
      blob = ActiveStorage::Blob.create_after_upload!(
                                                        io: File.open('src/assets/test_image.png'),
                                                        filename: 'test_image.png',
                                                        content_type: 'image/png'
                                                      )
      item1 = Item.create!(user_id: user.id, season: "spring", clothing_type: "tops", size: "L", color: "red")
      item2 = Item.create!(user_id: user.id, season: "summer", clothing_type: "shoes", size: "L", color: "black")
      item3 = Item.create!(user_id: user.id, season: "fall", clothing_type: "bottoms", size: "L", color: "black")
      item4 = Item.create!(user_id: user2.id, season: "summer", clothing_type: "shoes", size: "L", color: "black")

      Item.all.each do |item|
        item.image.attach(blob)
      end

      get "/api/v1/users/#{user.id}/items"

      items_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(items_response).to have_key(:data)
      expect(items_response[:data]).to be_an(Array)
      expect(items_response[:data].length).to eq(3)

      items_response[:data].each do |item|
        expect(item).to have_key(:id)
        expect(item).to have_key(:type)
        expect(item).to have_key(:attributes)
        expect(item[:attributes]).to have_key(:user_id)
        expect(item[:attributes][:user_id]).to be_a(Integer)
        expect(item[:attributes]).to have_key(:season)
        expect(item[:attributes][:season]).to be_a(String)
        expect(item[:attributes]).to have_key(:clothing_type)
        expect(item[:attributes][:clothing_type]).to be_a(String)
        expect(item[:attributes]).to have_key(:size)
        expect(item[:attributes][:size]).to eq(nil).or be_a(String)
        expect(item[:attributes]).to have_key(:image_url)
        expect(item[:attributes][:image_url]).to be_a(String)
        expect(item[:attributes]).to have_key(:notes)
        expect(item[:attributes][:notes]).to eq(nil).or be_a(String)
      end
    end
  end

  context 'if the user does not have items' do 
    it 'returns an empty array' do 
      user = create(:user)

      get "/api/v1/users/#{user.id}/items"

      items_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(items_response).to have_key(:data)
      expect(items_response[:data]).to be_an(Array)
      expect(items_response[:data].length).to eq(0)
    end
  end
end