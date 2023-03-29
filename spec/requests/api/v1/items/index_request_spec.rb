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

      get "/api/v1/users/#{user.id}"

      items_response = JSON.parse(response.body, symbolize_names: true)
      require 'pry'; binding.pry
      expect(response).to be_successful
      expect(response.status).to eq(200)
      #item4 does NOT exist
    end
  end
end