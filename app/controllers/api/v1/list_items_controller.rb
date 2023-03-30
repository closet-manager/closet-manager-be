class Api::V1::ListItemsController < ApplicationController
  def create
    item = Item.find(params[:item_id])
    list = List.find(params[:list_id])
    
    ListItem.create!(item_id: item.id, list_id: list.id)

    render json: { message: "Item has been successfully added to #{list.name}" }, status: 201
  end
end