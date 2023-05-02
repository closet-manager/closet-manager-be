require 'rails_helper'

RSpec.describe EventItem, type: :model do
  describe 'relationships' do
    it { should belong_to(:event) }
    it { should belong_to(:item) }
  end
end