class Api::V1::ItemsController < ApplicationController
  respond_to :json, :xml

  def index
    user = User.find_by(id: params[:user_id])
    render  json: user.nil? ? "invalid user" : user.items.all
  end

  def new
    respond_with Item.find(params[:id])
  end

  def create
    respond_with :api_v1, Item.create(Item_params)
  end

  def show
    # respond_with Item.find(params[:id])
    @user = User.includes(:items).includes(:lists).find_by_id(params[:id])
    @items = @user.items
  end

  def update
    respond_with :v1, Item.update(params[:id], Item_params)
  end

  def delete
    respond_with Item.destroy(params[:id])
  end
end
