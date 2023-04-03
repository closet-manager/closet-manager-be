class Item < ApplicationRecord
  include Rails.application.routes.url_helpers
  after_save :ensure_image_attached

  belongs_to :user
  has_many :list_items, dependent: :destroy
  has_many :lists, through: :list_items, dependent: :destroy

  validates_presence_of :clothing_type, :season, :color
  validates :image, {
                      presence: true
                    }

  enum color: { unspecified: 0, red: 1, orange: 2, yellow: 3, green: 4, blue: 5, purple: 6, black: 7, white: 8, neutral: 9, multi: 10 }
  enum clothing_type: { other: 0, tops: 1, bottoms: 2, shoes: 3, accessories: 4, outerwear: 5 }
  enum season: { all_season: 0, spring: 1, summer: 2, fall: 3, winter: 4 }

  has_one_attached :image

  def image_url
    url_for(image)
  end

  def self.filter_by(season=nil, clothing_type=nil, color=nil)
    filter_hash = {}
    filter_hash[:season] = season if season.present?
    filter_hash[:clothing_type] = clothing_type if clothing_type.present?
    filter_hash[:color] = color if color.present?
    
    self.where(filter_hash)
  end

  private

  def ensure_image_attached
    unless image.attached?
      self.image.attach(io: File.open(Rails.root.join('src', 'assets', 'default-image.jpeg')), filename: 'default-image.jpeg', content_type: 'image/jpeg')
    end
  end
end