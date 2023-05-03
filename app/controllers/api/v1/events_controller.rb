class Api::V1::EventsController < ApplicationController
  def index
    events = Event.all_events_with_items
    render json: EventSerializer.new(events)
  end

  def create
    event = Event.find_by(outfit_date: params[:event][:outfit_date])
    if !event.nil?
      event_item = EventItem.create!(event_id: event.id, item_id: params[:event][:item_id])
      check_save(event, event_item)
    else
      event = Event.create!(event_params)
      event_item = EventItem.create!(event_id: event.id, item_id: params[:event][:item_id])
      check_save(event, event_item)
    end
  end

  private

  def event_params
    params.require(:event).permit(:outfit_date)
  end

  def check_save(event, event_item)
    if event.save && event_item.save
      render json: { "message": "Item successfully added to date." }, status: 201
    else
      render json: { "message": "Item was not added to date, please try again." }, status: 400
    end
  end
end