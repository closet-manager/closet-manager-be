require 'rails_helper'

describe 'GET /users/:id/items/find_all?' do
  context 'if the user exists and has items' do
    it 'can find a users items based on a query' do
      user = create(:user)
      blob = ActiveStorage::Blob.create_after_upload!(
                                                      io: File.open('src/assets/test_image.png'),
                                                      filename: 'test_image.png',
                                                      content_type: 'image/png'
                                                      )
      item1 = Item.create!(user_id: user.id, season: "spring", clothing_type: "tops", size: "L", color: "red")
      item2 = Item.create!(user_id: user.id, season: "spring", clothing_type: "shoes", size: "L", color: "black")
      item3 = Item.create!(user_id: user.id, season: "fall", clothing_type: "bottoms", size: "L", color: "blue")
      Item.all.each do |item|
        item.image.attach(blob)
      end

      get "/api/v1/users/#{user.id}/items/find_all?season=spring"

      items_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(items_response).to have_key(:data)
      expect(items_response[:data]).to be_a(Array)

      expect(items_response[:data][0]).to have_key(:id)
      expect(items_response[:data][0][:id]).to be_a(String)

      expect(items_response[:data][0]).to have_key(:type)
      expect(items_response[:data][0][:type]).to be_a(String)

      expect(items_response[:data][0]).to have_key(:attributes)
      expect(items_response[:data][0][:attributes]).to be_a(Hash)

      expect(items_response[:data][0][:attributes]).to have_key(:user_id)
      expect(items_response[:data][0][:attributes][:user_id]).to be_a(Integer)

      expect(items_response[:data][0][:attributes]).to have_key(:season)
      expect(items_response[:data][0][:attributes][:season]).to be_a(String)

      expect(items_response[:data][0][:attributes]).to have_key(:clothing_type)
      expect(items_response[:data][0][:attributes][:clothing_type]).to be_a(String)

      expect(items_response[:data][0][:attributes]).to have_key(:color)
      expect(items_response[:data][0][:attributes][:color]).to be_a(String)

      expect(items_response[:data][0][:attributes]).to have_key(:size)
      expect(items_response[:data][0][:attributes][:size]).to be_a(String)

      expect(items_response[:data][0][:attributes]).to have_key(:image_url)
      expect(items_response[:data][0][:attributes][:image_url]).to be_a(String)

      expect(items_response[:data][0][:attributes]).to have_key(:notes)
      expect(items_response[:data][0][:attributes][:notes]).to eq(nil)
    end

    it 'can find a users items based on two query filters' do
      user = create(:user)
      blob = ActiveStorage::Blob.create_after_upload!(
                                                      io: File.open('src/assets/test_image.png'),
                                                      filename: 'test_image.png',
                                                      content_type: 'image/png'
                                                      )
      item1 = Item.create!(user_id: user.id, season: "spring", clothing_type: "tops", size: "L", color: "red")
      item2 = Item.create!(user_id: user.id, season: "fall", clothing_type: "bottoms", size: "L", color: "black")
      item3 = Item.create!(user_id: user.id, season: "fall", clothing_type: "bottoms", size: "L", color: "blue")
      Item.all.each do |item|
        item.image.attach(blob)
      end

      get "/api/v1/users/#{user.id}/items/find_all?season=fall&clothing_type=bottoms"

      items_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(items_response).to have_key(:data)
      expect(items_response[:data]).to be_a(Array)
      expect(items_response[:data].count).to eq(2)
      expect(items_response[:data][0][:id]).to eq(item2.id.to_s)
      expect(items_response[:data][1][:id]).to eq(item3.id.to_s)

    end

    it 'can find a users items based on three query filters' do
      user = create(:user)
      blob = ActiveStorage::Blob.create_after_upload!(
                                                      io: File.open('src/assets/test_image.png'),
                                                      filename: 'test_image.png',
                                                      content_type: 'image/png'
                                                      )
      item1 = Item.create!(user_id: user.id, season: "spring", clothing_type: "tops", size: "L", color: "red")
      item2 = Item.create!(user_id: user.id, season: "fall", clothing_type: "bottoms", size: "L", color: "black")
      item3 = Item.create!(user_id: user.id, season: "fall", clothing_type: "bottoms", size: "L", color: "blue")
      Item.all.each do |item|
        item.image.attach(blob)
      end

      get "/api/v1/users/#{user.id}/items/find_all?season=fall&clothing_type=bottoms&color=blue"

      items_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(items_response).to have_key(:data)
      expect(items_response[:data]).to be_a(Array)
      expect(items_response[:data].count).to eq(1)
      expect(items_response[:data][0][:id]).to eq(item3.id.to_s)
    end

    it 'can return an empty array if no items match the filters' do
      user = create(:user)
      blob = ActiveStorage::Blob.create_after_upload!(
                                                      io: File.open('src/assets/test_image.png'),
                                                      filename: 'test_image.png',
                                                      content_type: 'image/png'
                                                      )
      item1 = Item.create!(user_id: user.id, season: "spring", clothing_type: "tops", size: "L", color: "red")
      item2 = Item.create!(user_id: user.id, season: "fall", clothing_type: "bottoms", size: "L", color: "black")
      item3 = Item.create!(user_id: user.id, season: "fall", clothing_type: "bottoms", size: "L", color: "blue")
      Item.all.each do |item|
        item.image.attach(blob)
      end

      get "/api/v1/users/#{user.id}/items/find_all?season=winter"

      items_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(items_response).to have_key(:data)
      expect(items_response[:data]).to be_a(Array)
      expect(items_response[:data]).to eq([])
      expect(items_response[:data].count).to eq(0)
    end
  end
end