class Api::V1::UsersController < ApplicationController
  before_filter :restrict_access, :except => [:create]
  respond_to :json, :xml

  def index
    @user = @current_user.includes(:lists).includes(:items)
  end

  def new
    respond_with User.new
  end

  def create
    @user = User.create(user_params) if user_params
    render template: "api/v1/users/show.json"
  end

  def show
    @user = User.includes(:lists).includes(:items).find_by_id(@current_user.id)
  end

  def update
    @current_user.update(user_params) if user_params
    render json: @current_user
  end

  def delete
    @current_user.delete
    render json: { message: "User successfully deleted" }
  end

  private

  def user_params
    params.require(:user).permit(:full_name, :email, :password, :password_confirmation) if params.has_key? "user"
  end
end
