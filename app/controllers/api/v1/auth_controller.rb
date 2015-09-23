class Api::V1::AuthController < ApplicationController
  before_filter :restrict_access, :except => [:login]
  respond_to :json, :xml

  def login
    user = User.find_by_email(auth_params[:email])
    if user && user.authenticate(auth_params[:password])
      valid_token = user.api_keys.valid_tokens.first
      key = valid_token.nil? ? ApiKey.create(user_id: user.id) : valid_token
      render json: {token: key.token}
    else
      unauthorized!
    end
  end

  def logout
    @api_key.deactivate
    @api_key.save
    respond_with :api_v1, "Logged out successfully"
  end

  private

  def auth_params
    params.require(:auth).permit(:email, :password)
  end

end
