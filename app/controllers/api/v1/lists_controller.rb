class Api::V1::ListsController < ApplicationController
  def index
    user = User.find(params[:user_id])

    render json: ListSerializer.new(user.lists)
  end

  def show
    list = List.find(params[:id])

    render json: ListSerializer.new(list)
  end

  def create
    @user = User.find(params[:user_id])
    @list = List.create!(list_params)

    if @list.save!
      # Tells the UserMailer to send a list creation email after save
      UserMailer.with(user: @user, list: @list).list_creation_email.deliver_now
    end

    render json: ListSerializer.new(@list), status: 201
  end

  def destroy
    list = List.find(params[:id])
    list.destroy

    render json: { message: "List has been successfully deleted" }
  end

  private

  def list_params
    params.require(:list).permit(:name).merge(user_id: @user.id)
  end
end