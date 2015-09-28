require 'rails_helper'

describe Api::V1::AuthController, type: :controller do
  render_views

  before :each do
    @user = create :user, password: "password"
    @list = create(:list, user_id: @user.id)
  end

  it "should return an active token when a user logs in" do
    post :login, auth: { email: @user.email, password: "password"}

    resp = JSON.parse(response.body)

    expect(resp["token"]).to eq @user.active_api_key.token
  end

  it "should deactivate a user's token when the user logs out" do
    expect(@user.active_api_key).not_to be nil

    get :logout, token: @user.active_api_key.token

    expect(@user.active_api_key).to be nil
  end


end
