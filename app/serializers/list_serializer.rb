class ListSerializer
  include JSONAPI::Serializer
  
  attributes :name,
             :user_id,
             :items
end
