require 'rails_helper'

describe 'GET /event_items/find_all?date={outfit_date}' do
  context 'if the event exists' do
    it 'returns an event and all of its items' do
      user = create(:user)
      event = Event.create!(outfit_date: Date.today)
      item1 = Item.create(user_id: user.id, clothing_type: "tops")
      item2 = Item.create(user_id: user.id, clothing_type: "tops")
      item3 = Item.create(user_id: user.id, clothing_type: "tops")
      event_item1 = EventItem.create!(event_id: event.id, item_id: item1.id)
      event_item2 = EventItem.create!(event_id: event.id, item_id: item2.id)
      event_item3 = EventItem.create!(event_id: event.id, item_id: item3.id)

      get "/api/v1/event_items/find_all?date=#{event.outfit_date}"

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(response_body).to have_key(:data)
      expect(response_body[:data]).to be_an(Array)

      response_body[:data].each do |item|
        expect(item).to have_key(:id)
        expect(item).to have_key(:type)
        expect(item).to have_key(:attributes)
        expect(item[:attributes]).to have_key(:user_id)
        expect(item[:attributes][:user_id]).to be_a(Integer)
        expect(item[:attributes]).to have_key(:season)
        expect(item[:attributes][:season]).to be_a(String)
        expect(item[:attributes]).to have_key(:clothing_type)
        expect(item[:attributes][:clothing_type]).to be_a(String)
        expect(item[:attributes]).to have_key(:size)
        expect(item[:attributes][:size]).to eq(nil).or be_a(String)
        expect(item[:attributes]).to have_key(:image_url)
        expect(item[:attributes][:image_url]).to be_a(String)
        expect(item[:attributes]).to have_key(:notes)
        expect(item[:attributes][:notes]).to eq(nil).or be_a(String)
      end
    end
  end

  context 'if the event does not exists' do
    it 'returns an error message' do
      get "/api/v1/event_items/find_all?date=#{Date.today}"

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      expect(response_body).to have_key(:error)
      expect(response_body[:error]).to be_an(Array)

      expect(response_body).to have_key(:error)
      expect(response_body[:error]).to be_a(Array)
      expect(response_body[:error][0]).to have_key(:title)
      expect(response_body[:error][0][:title]).to be_a(String)
      expect(response_body[:error][0]).to have_key(:status)
      expect(response_body[:error][0][:status]).to be_a(String)
    end
  end

  context 'if the date is not passed in' do
    it 'returns an error message' do
      get "/api/v1/event_items/find_all?date="

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      expect(response_body).to have_key(:error)
      expect(response_body[:error]).to be_an(Array)

      expect(response_body).to have_key(:error)
      expect(response_body[:error]).to be_a(Array)
      expect(response_body[:error][0]).to have_key(:title)
      expect(response_body[:error][0][:title]).to be_a(String)
      expect(response_body[:error][0]).to have_key(:status)
      expect(response_body[:error][0][:status]).to be_a(String)
    end
  end
end