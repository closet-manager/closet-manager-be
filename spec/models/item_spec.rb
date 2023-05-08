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
  end

  describe 'class methods' do
    describe '#filter_by' do
      it 'can filter a users items' do
        user = create(:user)

        item1 = Item.create!(user_id: user.id, season: "spring", clothing_type: "tops", size: "L", color: "orange", favorite: true)
        item2 = Item.create!(user_id: user.id, season: "spring", clothing_type: "shoes", size: "L", color: "black", favorite: true)
        item3 = Item.create!(user_id: user.id, season: "fall", clothing_type: "bottoms", size: "L", color: "blue", favorite: false)
        item4 = Item.create!(user_id: user.id, season: "fall", clothing_type: "bottoms", size: "L", color: "blue", favorite: false)
        item5 = Item.create!(user_id: user.id, season: "fall", clothing_type: "tops", size: "L", color: "orange", favorite: false)

        #season
        expect(user.items.filter_by("spring")).to eq([item1, item2])
        expect(user.items.filter_by("winter")).to eq([])

        #clothing_type
        expect(user.items.filter_by(nil, "bottoms", nil, false)).to eq([item3, item4])
        expect(user.items.filter_by(nil, "accessories", nil, true)).to eq([])

        #color
        expect(user.items.filter_by(nil, nil, "orange", true)).to eq([item1])
        expect(user.items.filter_by(nil, nil, "unspecified", false)).to eq([])

        #season && clothing_type && color
        expect(user.items.filter_by("fall", "bottoms", "blue", false)).to eq([item3, item4])
        expect(user.items.filter_by("fall", "bottoms", "unspecified", true)).to eq([])

        #season && clothing_type
        expect(user.items.filter_by("fall", "tops", nil, false)).to eq([item5])
        expect(user.items.filter_by("fall", "other", nil, true)).to eq([])

        #season && color
        expect(user.items.filter_by("fall", nil, "blue", false)).to eq([item3, item4])
        expect(user.items.filter_by("fall", nil, "unspecified", true)).to eq([])

        #clothing_type && color
        expect(user.items.filter_by(nil, "bottoms", "blue", false)).to eq([item3, item4])
        expect(user.items.filter_by(nil, "other", "blue", true)).to eq([])
        
        #season && clothing_type && color && favorite
        expect(user.items.filter_by("fall", "bottoms", "blue", false)).to eq([item3, item4])
        expect(user.items.filter_by("fall", "other", "blue", true)).to eq([])
      end
    end
  end
end