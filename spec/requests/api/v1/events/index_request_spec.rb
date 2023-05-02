require 'rails_helper'

describe 'GET /events' do
  context 'if the events exist' do
    it 'returns all the events' do
      user = create(:user)
      event1 = Event.create!(outfit_date: Date.today)
      event2 = Event.create!(outfit_date: Date.today+1.day)
      item1 = Item.create(user_id: user.id, clothing_type: "tops")
      item2 = Item.create(user_id: user.id, clothing_type: "bottoms")
      item3 = Item.create(user_id: user.id, clothing_type: "tops")
      event_item1 = EventItem.create!(event_id: event1.id, item_id: item1.id)
      event_item2 = EventItem.create!(event_id: event1.id, item_id: item2.id)
      event_item3 = EventItem.create!(event_id: event2.id, item_id: item3.id)

      get '/api/v1/events'

      events_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(events_response).to have_key(:data)
      expect(events_response[:data]).to be_an(Array)

      events_response[:data].each do |event|
        expect(event).to have_key(:id)
        expect(event[:id]).to be_a(String)

        expect(event).to have_key(:type)
        expect(event[:type]).to be_a(String)
        
        expect(event).to have_key(:attributes)
        expect(event[:attributes]).to be_a(Hash)

        expect(event[:attributes]).to have_key(:outfit_date)
        expect(event[:attributes][:outfit_date]).to be_a(String)
      end
    end
  end

  context 'if there is no event' do
    it 'returns an empty array' do
      get '/api/v1/events'

      events_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(events_response).to have_key(:data)
      expect(events_response[:data]).to be_an(Array)
      expect(events_response[:data]).to eq([])
    end
  end
end