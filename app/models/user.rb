class User < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :list_items, through: :items, dependent: :destroy
  has_many :lists, through: :list_items, dependent: :destroy

  validates_presence_of :first_name, :last_name, :email
end