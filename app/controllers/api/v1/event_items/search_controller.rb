class Api::V1::EventItems::SearchController < ApplicationController
  def index
    event = Event.find_by!(outfit_date: params[:date])
    render json: ItemSerializer.new(event.items)
  end
end