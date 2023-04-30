class Api::V1::EventsController < ApplicationController
  def create
    event = Event.create!(event_params)
    render json: EventSerializer.new(event), status: 201
  end

  private

  def event_params
    params.require(:event).permit(:outfit_date)
  end
end