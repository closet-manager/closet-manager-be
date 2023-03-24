require 'rails_helper'

RSpec.describe List, type: :model do
  describe 'relationships' do
    it { should belong_to(:user).through(:item) }
    it { should have_many(:list_items) }
    it { should have_many(:items).through(:list_items) }
  end
end