require 'rails_helper'

RSpec.describe ListItem, type: :model do
  describe 'relationships' do
    it { should belong_to(:item) }
    it { should belong_to(:list) }
  end
end