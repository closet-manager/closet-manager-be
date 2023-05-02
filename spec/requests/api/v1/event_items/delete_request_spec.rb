require 'rails_helper'

describe 'DELETE /items/:item_id/date' do
  context 'when the event item exists' do
    it 'deletes the event item without deleting the associated event and item' do
      user = create(:user)
      event = Event.create!(outfit_date: Date.today)
      item1 = Item.create(user_id: user.id, clothing_type: "tops")
      item2 = Item.create(user_id: user.id, clothing_type: "tops")
      item3 = Item.create(user_id: user.id, clothing_type: "tops")
      event_item1 = EventItem.create!(event_id: event.id, item_id: item1.id)
      event_item2 = EventItem.create!(event_id: event.id, item_id: item2.id)
      event_item3 = EventItem.create!(event_id: event.id, item_id: item3.id)

      expect(EventItem.count).to eq(3)
      expect(Item.count).to eq(3)
      expect(Event.count).to eq(1)
      expect(User.count).to eq(1)

      delete "/api/v1/items/#{item1.id}/#{event.outfit_date}"

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect{EventItem.find(event_item1.id)}.to raise_error(ActiveRecord::RecordNotFound)
      expect(EventItem.count).to eq(2)
      expect(Item.count).to eq(3)
      expect(Event.count).to eq(1)
      expect(User.count).to eq(1)
    end
  end

  context 'when the item does not exists' do
    it 'returns an error message' do
      event = Event.create!(outfit_date: Date.today)

      delete "/api/v1/items/9999999999999999/#{event.outfit_date}"

      event_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      expect(event_response).to have_key(:error)
      expect(event_response[:error]).to be_a(Array)
      expect(event_response[:error][0]).to have_key(:title)
      expect(event_response[:error][0][:title]).to be_a(String)
      expect(event_response[:error][0]).to have_key(:status)
      expect(event_response[:error][0][:status]).to be_a(String)
    end
  end

  context 'when the date does not exists' do
    it 'returns an error message' do
      user = create(:user)
      event = Event.create!(outfit_date: Date.today)
      item1 = Item.create(user_id: user.id, clothing_type: "tops")
      event_item1 = EventItem.create!(event_id: event.id, item_id: item1.id)

      delete "/api/v1/items/#{item1.id}/#{Date.today+1.day}"

      event_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      expect(event_response).to have_key(:error)
      expect(event_response[:error]).to be_a(Array)
      expect(event_response[:error][0]).to have_key(:title)
      expect(event_response[:error][0][:title]).to be_a(String)
      expect(event_response[:error][0]).to have_key(:status)
      expect(event_response[:error][0][:status]).to be_a(String)
    end
  end
end