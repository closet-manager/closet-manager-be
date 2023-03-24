require 'rails_helper'

RSpec.describe List, type: :model do
  describe 'relationships' do
    it { should have_many(:list_items) }
    it { should have_many(:items).through(:list_items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end
end