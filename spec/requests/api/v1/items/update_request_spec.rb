require 'rails_helper'

describe 'PATCH /users/:user_id/items/:item_id' do
  context 'if the item is successfully updated' do
    it 'udpates the item' do
      user = create(:user)
    
      blob = ActiveStorage::Blob.create_after_upload!(
                                                        io: File.open('src/assets/test_image.png'),
                                                        filename: 'test_image.png',
                                                        content_type: 'image/png'
                                                      )
      item = Item.create!(user_id: user.id, season: "spring", clothing_type: "tops", size: "L", color: "red", notes: "in closet")

      Item.all.each do |item|
        item.image.attach(blob)
      end

      previous_item = Item.last

      item_params = { notes: "Steph currently has this top",
                      color: "black"
                    }
      headers = { "CONTENT_TYPE" => "application/json" }

      patch "/api/v1/users/#{user.id}/items/#{item.id}", headers: headers, params: JSON.generate({item: item_params})
      response_body = JSON.parse(response.body, symbolize_names: true)

      item = Item.find_by(id: item.id)

      expect(response).to be_successful
      expect(item.notes).to eq("Steph currently has this top")
      expect(item.color).to eq("black")
      expect(item.notes).to_not eq("in closet")
      expect(item.color).to_not eq("red")
    end
  end
end