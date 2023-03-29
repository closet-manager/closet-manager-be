class Api::V1::Items::SearchController < ApplicationController
  def show
    user = User.find(params[:user_id])

    render json: ItemSerializer.new(user.items.filter_by(params[:season], params[:clothing_type], params[:color]))
  end
end