class UsersController < ApplicationController
  skip_before_action :authorize_request, only: :create

  # routes viewuser
  def index
    # menampilkan semua user yanh sudah dibuat
    users = User.where.not(id: @current_user.id)
    json_response(users)
  end

  # membuat user dengan memasukkan email serta password
  def create
    user = User.create!(user_params)
    auth_token = AuthenticateUser.new(user.email, user.password).call
    response = { message: MessageResponse.account_created, auth_token: auth_token }
    json_response(response, :created)
  end

  private

  def user_params
    params.permit(
      :name,
      :email,
      :password,
      :password_confirmation
    )
  end
end
