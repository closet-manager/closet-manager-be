class Api::V1::ListsController < ApplicationController
  def index
    user = User.find(params[:user_id])

    render json: ListSerializer.new(user.lists)
  end

  def create
    @user = User.find(params[:user_id])
    list = List.create!(list_params)

    render json: ListSerializer.new(list), status: 201
  end

  private

    def list_params
      params.require(:list).permit(:name).merge(user_id: @user.id)
    end
end