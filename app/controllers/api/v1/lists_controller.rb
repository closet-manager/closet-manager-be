class Api::V1::ListsController < ApplicationController
  def index
    user = User.find(params[:user_id])

    render json: ListSerializer.new(user.lists)
  end
end