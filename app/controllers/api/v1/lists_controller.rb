class Api::V1::ListsController < ApplicationController
  before_filter :restrict_access
  respond_to :json, :xml

  def index
    user = User.find_by(id: params[:user_id])
    respond_with user.nil? ? "invalid user" : user.lists.all
  end

  def new
    respond_with List.find(params[:id])
  end

  def create
    @item = @current_user.items.find_by(user_id: params[:user_id], id: params[:id])
    @list = @item.items.create(item_params)
    render partial: "api/v1/items/show"
  end

  def show
    respond_with List.find(params[:id])
  end

  def update
    respond_with :v1, List.update(params[:id], List_params)
  end

  def delete
    respond_with List.destroy(params[:id])
  end
end
