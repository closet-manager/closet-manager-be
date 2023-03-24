require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to(:user) }
    it { should have_many(:list_items) }
    it { should have_many(:lists).through(:list_items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:clothing_type) }
    it { should validate_presence_of(:season) }
    it { should validate_presence_of(:color) }
    it { should validate_presence_of(:image_url) }
  end
end