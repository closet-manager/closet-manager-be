require 'rails_helper'

describe 'GET /users/:id/lists/:list_id/items' do
  context 'if the user and list exist' do
    it 'returns a list and all of its items' do
      user = create(:user)
      list = List.create(user_id: user.id, name: "Cabo Trip")
      item1 = Item.create(user_id: user.id, clothing_type: "tops")
      item2 = Item.create(user_id: user.id, clothing_type: "tops")
      item3 = Item.create(user_id: user.id, clothing_type: "tops")

      blob = ActiveStorage::Blob.create_after_upload!(
                                                  io: File.open('src/assets/test_image.png'),
                                                  filename: 'test_image.png',
                                                  content_type: 'image/png'
                                                )

      Item.all.each do |item|
        item.image.attach(blob)
      end

      get "/api/v1/users/#{user.id}/lists/#{list.id}/items"

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(response_body).to have_key(:data)
      expect(response_body[:data]).to be_an(Array)

      response_body[:data].each do |item|
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

    it 'returns an empty array if theres no items in the list' do
      user = create(:user)
      list = List.create(user_id: user.id, name: "Cabo Trip")

      get "/api/v1/users/#{user.id}/lists/#{list.id}/items"

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(response_body).to have_key(:data)
      expect(response_body[:data]).to be_an(Array)
      expect(response_body[:data]).to eq([])
    end
  end
end