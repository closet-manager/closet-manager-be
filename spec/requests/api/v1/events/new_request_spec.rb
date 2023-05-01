require 'rails_helper'

describe 'POST /events' do
  context 'if the event is successfully created' do
    it 'creates an event' do
      user = create(:user)

      item = Item.create!(user_id: user.id, season: "spring", clothing_type: "tops", size: "L", color: "red", notes: "in closet")
      
      event_params = { 
        outfit_date: Date.today.strftime('%Y-%m-%d'),
        item_id: item.id
      }

      headers = {"CONTENT_TYPE": "application/json"}

      expect(Event.count).to eq(0)
      expect(EventItem.count).to eq(0)

      post '/api/v1/events', headers: headers, params: JSON.generate(event: event_params)

      event_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(201)

      expect(event_response).to have_key(:message)
      expect(event_response[:message]).to be_a(String)

      expect(Event.count).to eq(1)
      expect(EventItem.count).to eq(1)
    end
  end

  context 'if the event is already created' do
    it 'can create multiple event items for one event' do
      user = create(:user)
      event = Event.create!(outfit_date: Date.today.strftime('%Y-%m-%d'))
      item = Item.create!(user_id: user.id, season: "spring", clothing_type: "tops", size: "L", color: "red", notes: "in closet")
      
      event_params = { 
        outfit_date: Date.today.strftime('%Y-%m-%d'),
        item_id: item.id
      }

      event_params2 = { 
        outfit_date: Date.today.strftime('%Y-%m-%d'),
        item_id: item.id
      }

      event_params3 = { 
        outfit_date: Date.today.strftime('%Y-%m-%d'),
        item_id: item.id
      }

      headers = {"CONTENT_TYPE": "application/json"}

      expect(Event.count).to eq(1)
      expect(EventItem.count).to eq(0)

      post '/api/v1/events', headers: headers, params: JSON.generate(event: event_params)

      event_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(201)

      expect(event_response).to have_key(:message)
      expect(event_response[:message]).to be_a(String)

      expect(Event.count).to eq(1)
      expect(EventItem.count).to eq(1)
      
      post '/api/v1/events', headers: headers, params: JSON.generate(event: event_params2)
      expect(Event.count).to eq(1)
      expect(EventItem.count).to eq(2)
            
      post '/api/v1/events', headers: headers, params: JSON.generate(event: event_params3)
      expect(Event.count).to eq(1)
      expect(EventItem.count).to eq(3)
    end
  end

  context 'if the item does not exist' do
    it 'returns an error' do
      user = create(:user)
      event = Event.create!(outfit_date: Date.today.strftime('%Y-%m-%d'))
      
      event_params = { 
        outfit_date: Date.today.strftime('%Y-%m-%d'),
        item_id: 9999999
      }

      headers = {"CONTENT_TYPE": "application/json"}

      expect(Event.count).to eq(1)
      expect(EventItem.count).to eq(0)

      post '/api/v1/events', headers: headers, params: JSON.generate(event: event_params)

      event_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      expect(event_response).to have_key(:error)
      expect(event_response[:error]).to be_a(Array)
      expect(event_response[:error][0]).to have_key(:title)
      expect(event_response[:error][0][:title]).to be_a(String)
      expect(event_response[:error][0]).to have_key(:status)
      expect(event_response[:error][0][:status]).to be_a(String)

      expect(Event.count).to eq(1)
      expect(EventItem.count).to eq(0)
    end
  end
end