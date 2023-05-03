require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'relationships' do
    it { should have_many(:event_items) }
    it { should have_many(:items).through(:event_items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:outfit_date) }
    it { should validate_uniqueness_of(:outfit_date) }
  end

  describe 'class methods' do
    describe '#find_all_events_with_items' do
      it 'returns all events that have items' do
        user = create(:user)
        item1 = Item.create(user_id: user.id, clothing_type: "tops")
        event1 = Event.create!(outfit_date: Date.today)
        event2 = Event.create!(outfit_date: Date.today+1.day)
        event3 = Event.create!(outfit_date: Date.today+2.day)
        event_item1 = EventItem.create!(event_id: event1.id, item_id: item1.id)
        event_item2 = EventItem.create!(event_id: event2.id, item_id: item1.id)

        expect(Event.all_events_with_items).to eq([event1, event2])
        expect(Event.all_events_with_items).to_not include([event3])
      end
    end
  end
end