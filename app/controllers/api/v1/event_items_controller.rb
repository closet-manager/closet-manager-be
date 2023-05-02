class Api::V1::EventItemsController < ApplicationController
  def destroy
    event = Event.find_by(outfit_date: params[:date])
    event_item = EventItem.find_by!(event_id: event.id, item_id: params[:item_id])
    event_item.delete
    render json: { message: "The item has been deleted from this date" }, status: 200
  end
end