class Api::V1::UsersController < ActionController::API
  def show
    user = User.find(params[:id])

    render json: UserSerializer.new(user)
  end
end