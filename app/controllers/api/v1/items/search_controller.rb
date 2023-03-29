class Api::V1::Items::SearchController < ApplicationController
  def show
    user = User.find(params[:user_id])

    render json: ItemSerializer.new(user.items.filter_by(params[:season], params[:clothing_type], params[:color]))




    # if params[:season] && params[:clothing_type] && params[:color]
    #   render json: ItemSerializer.new(items.filter_by(params[:season], params[:clothing_type], params[:color]))
    # elsif params[:season] && params[:clothing_type]
    #   render json: ItemSerializer.new(items.filter_by(params[:season], params[:clothing_type]))
    # elsif params[:season] && params[:color]
    #   render json: ItemSerializer.new(items.filter_by(params[:season], nil, params[:color]))
    # elsif params[:clothing_type] && params[:color]
    #   render json: ItemSerializer.new(items.filter_by(nil, params[:clothing_type], params[:color]))
    # elsif params[:season]
    #   render json: ItemSerializer.new(items.filter_by(season: params[:season]))
    # elsif params[:clothing_type]
    #   render json: ItemSerializer.new(items.filter_by(nil, params[:clothing_type]))
    # else params[:color]
    #   render json: ItemSerializer.new(items.filter_by(nil, nil, params[:color]))
    # end
  end
end