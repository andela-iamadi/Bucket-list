include ActionController::HttpAuthentication::Token::ControllerMethods
include ActionController::MimeResponds

class ApplicationController < ActionController::API
  include ActionController::ImplicitRender
  include ActionController::Helpers
  include ActionController::Caching

  private

  def restrict_access
    unless (restrict_access_by_header || restrict_access_by_params) && token_is_valid
      unauthorized!
      return
    end
    @current_user = @api_key.user
  end

  def restrict_access_by_header
    return true if @api_key
    authenticate_with_http_token do |token|
      @api_key = ApiKey.find_by_token(token)
    end
  end

  def restrict_access_by_params
    return true if @api_key
    @api_key = ApiKey.find_by_token(params[:token])
  end

  def token_is_valid
    @api_key && @api_key.active && !@api_key.expired?
  end

  def unauthorized!
    render json: {message: 'Not Authorized'}, status: 401
  end
end
