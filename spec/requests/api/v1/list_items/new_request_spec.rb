require 'rails_helper' 

describe 'POST /items/:item_id/lists/:list_id/list_items' do
  context 'if the list item is successfully created' do
    it 'create an item for a list' do 
      user = create(:user)

      blob = ActiveStorage::Blob.create_after_upload!(
                                                        io: File.open('src/assets/test_image.png'),
                                                        filename: 'test_image.png',
                                                        content_type: 'image/png'
                                                      )
      
      item = Item.create!(user_id: user.id, season: "spring", clothing_type: "tops", size: "L", color: "red")
      item.image.attach(blob)

      list = List.create!(name: "Bach Trip", user_id: user.id)
      # headers = { "CONTENT_TYPE": "application/json" }

      expect(ListItem.count).to eq(0)

      post "/api/v1/items/#{item.id}/lists/#{list.id}/list_items"

      list_item_response = JSON.parse(response.body, symbolize_names: true) 

      expect(response).to be_successful
      expect(response.status).to be(201)
      expect(ListItem.count).to eq(1)
      
      expect(list_item_response).to have_key(:message)
      expect(list_item_response[:message]).to be_a(String)
      expect(list_item_response[:message]).to match(/Item has been successfully added to #{list.name}/)
    end
  end

  context 'if the item does not exist' do
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
      # headers = { "CONTENT_TYPE": "application/json" }

      expect(ListItem.count).to eq(0)

      post "/api/v1/items/#{Item.last.id+1}/lists/#{list.id}/list_items"

      list_item_response = JSON.parse(response.body, symbolize_names: true) 

      expect(response).to_not be_successful
      expect(response.status).to be(404)
      expect(ListItem.count).to eq(0)
      
      expect(list_item_response).to have_key(:error)
      expect(list_item_response[:error][0]).to have_key(:title)
      expect(list_item_response[:error][0][:title]).to be_a(String)

      expect(list_item_response[:error][0]).to have_key(:status)
      expect(list_item_response[:error][0][:status]).to be_a(String)

      expect(list_item_response[:error][0][:title]).to match(/Couldn't find Item with 'id'=#{Item.last.id+1}/)
    end
  end

  context 'if the list does not exist' do
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
      # headers = { "CONTENT_TYPE": "application/json" }

      expect(ListItem.count).to eq(0)

      post "/api/v1/items/#{item.id}/lists/#{List.last.id+1}/list_items"

      list_item_response = JSON.parse(response.body, symbolize_names: true) 

      expect(response).to_not be_successful
      expect(response.status).to be(404)
      expect(ListItem.count).to eq(0)
      
      expect(list_item_response).to have_key(:error)
      expect(list_item_response[:error][0]).to have_key(:title)
      expect(list_item_response[:error][0][:title]).to be_a(String)

      expect(list_item_response[:error][0]).to have_key(:status)
      expect(list_item_response[:error][0][:status]).to be_a(String)

      expect(list_item_response[:error][0][:title]).to match(/Couldn't find List with 'id'=#{List.last.id+1}/)
    end
  end
end