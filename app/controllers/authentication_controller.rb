class AuthenticationController < ApplicationController
  before_action :authorize_request, except: [:login, :register]

  # POST /auth/login
  def login
    @current_user = User.find_by_email(params[:email])
    if @current_user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @current_user.id)
      time = Time.now + 24.hours.to_i
      render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                     id: @current_user.id }, status: :ok
    else
      render json: { error: 'Wrong credentials' }, status: :unauthorized
    end
  end

  # POST /auth/register
  def register
    @user = User.new(user_params)
    if @user.save
      token = JsonWebToken.encode(user_id: @user.id)
      time = Time.now + 24.hours.to_i
      render json: {
        user: @user,
        token: token,
        exp: time.strftime("%m-%d-%Y %H:%M"),
        id: @user.id
      },
      status: :created
    else
      render json: { errors: @user.errors },
              status: :unprocessable_entity
    end
  end

  def user_params
    params.require(:user).permit(
      :last_name, :first_name, :email, :born_date, :password, :password_confirmation
    )
  end
end
