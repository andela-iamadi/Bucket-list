class Api::V1::ItemsController < ApplicationController
  before_filter :restrict_access
  respond_to :json, :xml

  def index
    list = @current_user.lists.find_by_id(params[:list_id])
    @items = list.items if list
  end

  def new
    respond_with item.find(params[:id])
  end

  def create
    list = @current_user.lists.find_by(id: params[:list_id])
    @item = list.items.create(items_params) if (list && items_params)
    render partial: "api/v1/items/show"
  end

  def show
    @list = @current_user.lists.find_by(id: params[:list_id])
    @item = @list.items.find_by_id(params[:id])
    render partial: "api/v1/items/show"
  end

  def update
    @list = @current_user.lists.find_by_id(params[:list_id])
    @item = @list.items.find_by_id(params[:id]) if @list
    @item.update(items_params) if (@item && items_params)
    render partial: "api/v1/items/show"
  end

  def destroy
    list = @current_user.lists.find_by_id(params[:list_id])
    item = list.items.find_by_id(params[:id]) if list
    item.destroy if item
    redirect_to api_v1_list_items_path, status: 303
  end

  private

  def items_params
    params.require(:item).permit(:name) if params.has_key? "item"
  end
end
