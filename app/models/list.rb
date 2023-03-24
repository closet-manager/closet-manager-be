class List < ApplicationRecord
  has_many :list_items, dependent: :destroy
  has_many :items, through: :list_items, dependent: :destroy

  validates_presence_of :name
end