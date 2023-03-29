class Api::V1::ItemsController < ApplicationController

  def create
    user = User.find(params[:user_id])
    item = Item.create(item_params)
    if item.valid?
      render json: ItemSerializer.new(item)
    else
      render json: { errors: item.errors }, status: 400
    end
  end

  private 
  
  def item_params
    params.permit(:user_id, :season, :clothing_type, :size, :color, :image, :notes)
  end
end
