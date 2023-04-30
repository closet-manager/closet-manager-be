require 'rails_helper'

describe 'POST /events' do
  context 'if the event is successfully created' do
    it 'creates an event' do
      event_params = { outfit_date: Date.today.strftime('%Y-%m-%d') }

      headers = {"CONTENT_TYPE": "application/json"}

      post '/api/v1/events', headers: headers, params: JSON.generate(event: event_params)

      event_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(201)

      expect(event_response).to have_key(:data)
      expect(event_response[:data]).to be_a(Hash)
      
      expect(event_response[:data]).to have_key(:id)
      expect(event_response[:data][:id]).to be_a(String)
      
      expect(event_response[:data]).to have_key(:type)
      expect(event_response[:data][:type]).to be_a(String)
      
      expect(event_response[:data]).to have_key(:attributes)
      expect(event_response[:data][:attributes]).to be_a(Hash)
      
      expect(event_response[:data][:attributes]).to have_key(:outfit_date)
      expect(event_response[:data][:attributes][:outfit_date]).to be_a(String)
    end
  end
end