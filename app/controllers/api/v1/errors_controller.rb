class Api::V1::ErrorsController < ApplicationController
  respond_to :json, :xml

  def not_found
    status_code = params[:code] || 404
    render json: {error: "#{status_code}: This API doesn't support that request."} , status: status_code
  end

  def server_error
    status_code = params[:code] || 500
    render json: {error: "#{status_code}: There's been some kind of error."}, status: status_code
  end
end
