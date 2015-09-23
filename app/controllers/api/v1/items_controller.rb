class Api::V1::ItemsController < ApplicationController
  before_filter :restrict_access
  respond_to :json, :xml

  def index
    @items = @current_user.items.includes(:lists)
  end

  def new
    respond_with Item.find(params[:id])
  end

  def create
    @item = @current_user.items.create(item_params)
    render partial: "api/v1/items/show"
  end

  def show
    @item = @current_user.items.includes(:lists).find_by(id: params[:id])
    render partial: "api/v1/items/show"
  end

  def update
    @item = @current_user.items.includes(:lists).find_by(id: params[:id])
    @item.update(item_params) if @item
    render partial: "api/v1/items/show"
  end

  def destroy
    @item = @current_user.items.find_by_id(params[:id])
    @item.destroy if @item
    redirect_to api_v1_items_path, status: 303
  end

  private

  def item_params
    params.require(:item).permit(:name) if params.has_key? "item"
  end
end
