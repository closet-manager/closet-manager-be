require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_many(:items) }
    it { should have_many(:list_items).through(:items) }
    it { should have_many(:lists).through(:list_items) }
  end
end