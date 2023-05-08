class ItemSerializer
  include JSONAPI::Serializer
  
  attributes :user_id,
             :season,
             :clothing_type,
             :color,
             :size,
             :image_url,
             :notes,
             :favorite
end
