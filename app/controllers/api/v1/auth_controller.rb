class AuthController < ApplicationController
  def logon
    user = params.find_by_email(auth_params[:email])
    if user && user.authenticate(auth_params[:password])
      respond_with :api_v1, user.api_key.token
    else
      respond_with :api_v1, "invalid user"
    end
  end


end
