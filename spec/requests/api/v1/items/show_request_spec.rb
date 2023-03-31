require 'rails_helper'

describe 'GET /users/:user_id/items/:item_id' do
  context 'if a item exists' do
    it 'returns one item by ID' do
      user = create(:user)
      blob = ActiveStorage::Blob.create_after_upload!(
                                                        io: File.open('src/assets/test_image.png'),
                                                        filename: 'test_image.png',
                                                        content_type: 'image/png'
                                                      )
      item1 = Item.create!(user_id: user.id, season: "spring", clothing_type: "tops", size: "L", color: "red")
      item2 = Item.create!(user_id: user.id, season: "summer", clothing_type: "shoes", size: "L", color: "black")

      Item.all.each do |item|
        item.image.attach(blob)
      end

      get "/api/v1/users/#{user.id}/items/#{item1.id}"

      item_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(item_response).to have_key(:data)
      expect(item_response[:data]).to be_a(Hash)
      
      expect(item_response[:data]).to have_key(:id)
      expect(item_response[:data][:id]).to be_a(String)

      expect(item_response[:data]).to have_key(:type)
      expect(item_response[:data][:type]).to be_a(String)

      expect(item_response[:data]).to have_key(:attributes)
      expect(item_response[:data][:attributes]).to be_a(Hash)

      item_data = item_response[:data][:attributes]
      
      expect(item_data).to have_key(:season)
      expect(item_data[:season]).to be_a(String)

      expect(item_data).to have_key(:clothing_type)
      expect(item_data[:clothing_type]).to eq(nil).or be_a(String)

      expect(item_data).to have_key(:size)
      expect(item_data[:size]).to be_a(String)

      expect(item_data).to have_key(:image_url)
      expect(item_data[:image_url]).to be_a(String)

      expect(item_data).to have_key(:notes)
      expect(item_data[:notes]).to eq(nil).or be_a(String)
    end
  end
  
  context 'the item does not exist' do
    it 'returns an error message' do
      user = create(:user)
      blob = ActiveStorage::Blob.create_after_upload!(
                                                        io: File.open('src/assets/test_image.png'),
                                                        filename: 'test_image.png',
                                                        content_type: 'image/png'
                                                      )
      item1 = Item.create!(user_id: user.id, season: "spring", clothing_type: "tops", size: "L", color: "red")
      item2 = Item.create!(user_id: user.id, season: "summer", clothing_type: "shoes", size: "L", color: "black")

      Item.all.each do |item|
        item.image.attach(blob)
      end

      get "/api/v1/users/#{user.id}/items/#{Item.last.id+1}"

      item = JSON.parse(response.body, symbolize_names: true)
      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      
      expect(item).to have_key(:error)
      expect(item[:error][0][:title]).to match(/Couldn't find Item with 'id'=#{Item.last.id+1}/)
    end
  end
end