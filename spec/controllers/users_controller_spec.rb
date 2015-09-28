require "rails_helper"

RSpec.describe Api::V1::UsersController, type: :controller do
  render_views

  # POST /api/v1/users#create
  it "should create a user" do
    post :create, :user => {full_name: "John Doe", email: "john.doe@gmail.com", password: "password", password_confirmation: "password"}

    user_returned = JSON.parse(response.body)

    expect(user_returned["full_name"]).to eq "John Doe"
  end

  # PATCH /api/v1/users/1#update
  it "should edit a user" do
    user = create(:user, full_name: "John Doe")

    user_token = user.active_api_key.token
    post :update, :user => {full_name: "John Doey", email: "john.doe@gmail.com", password: "password", password_confirmation: "password"}, :token=>user_token

    user_returned = JSON.parse(response.body)

    expect(user_returned["full_name"]).to eq "John Doey"
  end

  # GET /api/v1/users#show
  it "should include a list of tasks along with a user's information" do
    user = create :user, full_name: "John Doe"
    list = create :list, name: "The first list", user_id: user.id
    create :item, name: "The first item", list_id: list.id

    get :show, token: user.active_api_key.token, format: :json

    user_returned = JSON.parse(response.body)

    expect(user_returned["full_name"]).to eq "John Doe"
    expect(user_returned["lists"][0]["name"]).to eq "The first list"
    expect(user_returned["lists"][0]["items"][0]["name"]).to eq "The first item"
  end

  # DELETE /api/v1/users#delete
  it 'should delete a user from database' do
    user = create :user

    expect(User.all.empty?).to be false

    get :delete, token: user.active_api_key.token, format: :json

    expect(User.all.empty?).to be true
  end

  # GET /api/v1/users#show
  it "should respond details for only a logged-in user" do
    user = create :user, full_name: "John Doe"

    get :show, format: :json
    resp = JSON.parse(response.body)

    expect(response.status).to eq 401
    expect(resp["message"]).to eq "Not Authorized"

    get :show, token: user.active_api_key.token, format: :json

    resp = JSON.parse(response.body)

    expect(response.status).to eq 200
    expect(resp["full_name"]).to eq "John Doe"
  end

end
