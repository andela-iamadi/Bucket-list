class Api::V1::UsersController < ApplicationController
  respond_to :json, :xml

  def index
    respond_with User.all
  end

  def new
    respond_with User.find(params[:id])
  end

  def create
    respond_with :api_v1, User.create(user_params)
  end

  def show
    # user = User.includes(:items).find_by_id(params[:id])
    @user = User.includes(:items).includes(:lists).find_by_id(params[:id])
    # respond_with user.as_json(only:[:id, :full_name, :email, :created_at, :updated_at], include: [{items: {only: [:id, :name]}}])
    # render "app/views/api/v1/user.json"
  end

  def update
    respond_with :api_v1, User.update(params[:id], user_params)
  end

  def delete
    respond_with User.destroy(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:full_name, :email, :password, :password_confirmation) if params.has_key? "user"
  end
end
