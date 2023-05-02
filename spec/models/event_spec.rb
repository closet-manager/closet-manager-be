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
end