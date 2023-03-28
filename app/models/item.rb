class Item < ApplicationRecord
  include Rails.application.routes.url_helpers

  belongs_to :user
  has_many :list_items, dependent: :destroy
  has_many :lists, through: :list_items, dependent: :destroy

  validates_presence_of :clothing_type, :season, :color
  validates :image, {
    presence: true
  }
  
  enum season: ["all season", "spring", "summer", "fall", "winter"]
  enum clothing_type: ["other", "tops", "bottoms", "shoes", "accessories", "outerwear"]
  enum color: ["unspecified", "red", "orange", "yellow", "green", "blue", "purple", "black", "white", "neutral", "multi"]
  
  # enum season: [:all_season, "spring", "summer", "fall", "winter"]
  has_one_attached :image # , service: :s3

  def image_url
    url_for(image)
  end

  def self.filter_by(season=nil, clothing_type=nil, color=nil)
    if clothing_type.nil? && color.nil?
      self
      .where("season = ?", "#{season}")
    elsif season.nil? && color.nil?
      self
      .where("clothing_type = ?", "#{clothing_type}")
    elsif season.nil? && clothing_type.nil?
      self
      .where("color = ?", "#{color}")
    elsif color.nil?
      self
      .where("season = ? AND clothing_type = ?", "#{season}", "#{clothing_type}")
    elsif clothing_type.nil?
      self
      .where("season = ? AND color = ?", "#{season}", "#{color}")
    elsif season.nil?
      self
      .where("clothing_type = ? AND color = ?", "#{clothing_type}", "#{color}")
    else
      self
      .where("season = ? AND clothing_type = ? AND color = ?", "#{season}", "#{clothing_type}", "#{color}")
    end
  end
end