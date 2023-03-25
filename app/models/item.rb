class Item < ApplicationRecord
  belongs_to :user
  has_many :list_items, dependent: :destroy
  has_many :lists, through: :list_items, dependent: :destroy

  validates_presence_of :clothing_type, :season, :color
  
  enum season: ["all season", "spring", "summer", "fall", "winter"]
  enum clothing_type: ["other", "tops", "bottoms", "shoes", "accessories", "outerwear"]
  enum color: ["unspecified", "red", "orange", "yellow", "green", "blue", "purple", "black", "white", "neutral", "multi"]

  has_one_attached :image, service: :s3
end