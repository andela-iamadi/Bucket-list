class Api::V1::ListsController < ApplicationController
  before_filter :restrict_access
  respond_to :json, :xml

  def index
    @lists = @current_user.lists.includes(:items)
  end

  def new
    respond_with list.find(params[:id])
  end

  def create
    @list = @current_user.lists.create(list_params) if list_params
    render partial: "api/v1/lists/show"
  end

  def show
    @list = @current_user.lists.includes(:items).find_by(id: params[:id])
    render partial: "api/v1/lists/show"
  end

  def update
    @list = @current_user.lists.includes(:items).find_by(id: params[:id])
    @list.update(list_params) if (@list && list_params)
    render partial: "api/v1/lists/show"
  end

  def destroy
    @list = @current_user.lists.find_by_id(params[:id])
    @list.destroy if @list
    redirect_to api_v1_lists_path, status: 303
  end

  private

  def list_params
    params.require(:list).permit(:name) if params.has_key? "list"
  end
end
