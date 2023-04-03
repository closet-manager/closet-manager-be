require 'rails_helper'

describe 'DELETE /items/:item_id' do
  context 'when the list item exists' do
    it 'deletes an item and its association on any custom lists' do 
      user = create(:user)
      blob = ActiveStorage::Blob.create_after_upload!(
        io: File.open('src/assets/test_image.png'),
        filename: 'test_image.png',
        content_type: 'image/png'
      )
      item1 = Item.create!(user_id: user.id, season: "summer", clothing_type: "tops", size: "L", color: "red")
      item2 = Item.create!(user_id: user.id, season: "summer", clothing_type: "bottoms", size: "L", color: "blue")
      item1.image.attach(blob)
      item2.image.attach(blob)
      list = List.create!(name: "Mexico Trip", user_id: user.id)
      list_item1 = ListItem.create!(item_id: item1.id, list_id: list.id)
      list_item2 = ListItem.create!(item_id: item2.id, list_id: list.id)


      expect(user.items.count).to eq(2)
      expect(list.items.count).to eq(2)

      delete "/api/v1/users/#{user.id}/items/#{item1.id}"

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect{Item.find(item1.id)}.to raise_error(ActiveRecord::RecordNotFound)
      expect(user.items.count).to eq(1)
      expect(list.items.count).to eq(1)
    end
  end

  context 'when the item does not exist' do
    it 'returns an error message' do
      user = create(:user)

      expect(user.items.count).to eq(0)

      delete "/api/v1/users/#{user.id}/items/1"
      response_body = JSON.parse(response.body, symbolize_names: true)
      
      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      expect(response_body).to have_key(:error)
      expect(response_body[:error]).to be_an(Array)
      expect(response_body[:error][0]).to be_a(Hash)
      expect(response_body[:error][0]).to have_key(:title)
      expect(response_body[:error][0][:title]).to be_a(String)
      expect(response_body[:error][0][:title]).to match("Couldn't find Item with 'id'=1")
      expect(response_body[:error][0]).to have_key(:status)
      expect(response_body[:error][0][:status]).to be_a(String)

      expect(user.items.count).to eq(0)
    end
  end
end
