class Api::V1::ItemsController < ApplicationController
  
  def create
    user = User.find(params[:user_id])
    item = Item.create(item_params)

    if item.save
      render json: ItemSerializer.new(item), status: 201
    else
      render json: { "message": "Please ensure no empty strings are passed in." }, status: 400
    end
  end
  
  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def update
    item = Item.find(params[:id])
    item.update(update_item_params)
    render json: ItemSerializer.new(item)
  end

  def index 
    user = User.find(params[:user_id])
    render json: ItemSerializer.new(user.items) 
  end

  def destroy 
    item = Item.find(params[:id])
    item.destroy

    render json: { message: "Item has been successfully deleted" }
  end

  private 
  
  def item_params
    params.permit(:user_id, :season, :clothing_type, :size, :color, :image, :notes)
  end
  
  def update_item_params
    params.require(:item).permit(:season, :clothing_type, :size, :color, :notes)
  end
end
