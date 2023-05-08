class Api::V1::Items::SearchController < ApplicationController
  def index
    user = User.find(params[:user_id])
    render json: ItemSerializer.new(user.items.filter_by(params[:season], params[:clothing_type], params[:color], params[:favorite]))
  end
end