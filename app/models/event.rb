class Event < ApplicationRecord
  has_many :event_items, dependent: :destroy
  has_many :items, through: :event_items, dependent: :destroy

  validates_presence_of :outfit_date
  validates_uniqueness_of :outfit_date

  def self.all_events_with_items
    self.joins(:event_items)
    .group(:id)
    .having('count(event_items.id) >= 1')
    .order(:id)
  end
end