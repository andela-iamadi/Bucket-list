class Api::V1::ListsController < ApplicationController
  respond_to :json, :xml

  def index
    user = User.find_by(id: params[:user_id])
    respond_with user.nil? ? "invalid user" : user.lists.all
  end

  def new
    respond_with List.find(params[:id])
  end

  def create
    respond_with :v1, List.create(List_params)
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
