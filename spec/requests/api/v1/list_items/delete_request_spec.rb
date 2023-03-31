require 'rails_helper'

describe 'DELETE /users/:user_id/list_items/:list_item_id' do
  context 'when the list item exists' do
    it 'deletes the list item without deleting the associated list and item' do
      user = create(:user)

      blob = ActiveStorage::Blob.create_after_upload!(
        io: File.open('src/assets/test_image.png'),
        filename: 'test_image.png',
        content_type: 'image/png'
      )

      item = Item.create!(user_id: user.id, season: "spring", clothing_type: "tops", size: "L", color: "red")
      item.image.attach(blob)

      list = List.create!(name: "Bach Trip", user_id: user.id)

      list_item = ListItem.create!(item_id: item.id, list_id: list.id)

      expect(ListItem.count).to eq(1)
      expect(Item.count).to eq(1)
      expect(List.count).to eq(1)
      expect(User.count).to eq(1)

      delete "/api/v1/users/#{user.id}/list_items/#{list_item.id}"

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect{ListItem.find(list_item.id)}.to raise_error(ActiveRecord::RecordNotFound)
      expect(ListItem.count).to eq(0)
      expect(Item.count).to eq(1)
      expect(List.count).to eq(1)
      expect(User.count).to eq(1)
    end
  end

  context 'when the list item does not exist' do
    it 'returns an error message' do
      user = create(:user)

      blob = ActiveStorage::Blob.create_after_upload!(
        io: File.open('src/assets/test_image.png'),
        filename: 'test_image.png',
        content_type: 'image/png'
      )

      item = Item.create!(user_id: user.id, season: "spring", clothing_type: "tops", size: "L", color: "red")
      item.image.attach(blob)

      list = List.create!(name: "Bach Trip", user_id: user.id)

      list_item = ListItem.create!(item_id: item.id, list_id: list.id)

      expect(ListItem.count).to eq(1)
      expect(Item.count).to eq(1)
      expect(List.count).to eq(1)
      expect(User.count).to eq(1)

      delete "/api/v1/users/#{user.id}/list_items/#{ListItem.last.id+1}"
      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      expect(response_body).to have_key(:error)
      expect(response_body[:error]).to be_an(Array)

  
      expect(response_body[:error][0]).to be_a(Hash)
      expect(response_body[:error][0]).to have_key(:title)
      expect(response_body[:error][0][:title]).to be_a(String)
      expect(response_body[:error][0][:title]).to match(/Couldn't find ListItem with 'id'=#{ListItem.last.id+1}/)
      
      expect(response_body[:error][0]).to have_key(:status)
      expect(response_body[:error][0][:status]).to be_a(String)

      expect(ListItem.count).to eq(1)
      expect(Item.count).to eq(1)
      expect(List.count).to eq(1)
      expect(User.count).to eq(1)
    end
  end
end

