require 'rails_helper'

describe 'DELETE /users/:user_id/list_items/:list_item_id' do
  context 'when the list item exists' do
    it 'deletes the list item' do
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
end