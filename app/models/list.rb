class List < ApplicationRecord
  has_many :list_items, dependent: :destroy
  has_many :items, through: :list_items, dependent: :destroy
  # belongs_to :user, through: :items
end