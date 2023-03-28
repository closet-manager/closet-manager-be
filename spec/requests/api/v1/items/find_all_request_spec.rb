require 'rails_helper'

describe 'GET /users/:id/items/find_all?' do
  context 'if the user exists and has items' do
    it 'can find a users items based on a query' do
      user = create(:user)
      item1 = Item.create!(user_id: user.id, season: "spring", clothing_type: "tops", size: "L", color: "red")
      item2 = Item.create!(user_id: user.id, season: "spring", clothing_type: "shoes", size: "L", color: "black")
      item3 = Item.create!(user_id: user.id, season: "fall", clothing_type: "bottoms", size: "L", color: "blue")

      get "/api/v1/users/#{user.id}/items/find_all?season=spring"

      items_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(items_response).to have_key(:data)
    end
  end
end