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
  
  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def update
    item = Item.find(params[:id])
    item.update(upate_item_params)
    render json: ItemSerializer.new(item)
  end

  def index 
    user = User.find(params[:user_id])
    render json: ItemSerializer.new(user.items) 
  end

  private 
  
  def item_params
    params.permit(:user_id, :season, :clothing_type, :size, :color, :image, :notes)
  end
  
  def upate_item_params
    params.require(:item).permit(:season, :clothing_type, :size, :color, :notes)
  end
end
