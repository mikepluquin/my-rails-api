class UsersController < ApplicationController
  before_action :authorize_request, except: :create
  before_action :find_user, except: :index

  # GET /users
  def index
    @users = User.all
    render json: @users, status: :ok
  end

  # GET /users/{id}
  def show
    render json: @user, status: :ok
  end

  # PUT /users/{id}
  def update
    if @user == @current_user
      if @user.update(user_params)
        render json: @user, status: :ok
      else
        render json: { errors: @user.errors.full_messages },
               status: :unprocessable_entity
      end
    else
      render status: :forbidden
    end
  end

  # DELETE /users/{id}
  def destroy
    if @user == @current_user
      @user.destroy
      render status: :no_content
    else
      render status: :forbidden
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'User not found' }, status: :not_found
  end

  def user_params
    params.require(:user).permit(
      :email, :username, :born_date, :password, :password_confirmation
    )
  end
end
