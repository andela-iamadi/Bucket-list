require 'rails_helper'

describe Api::V1::ListsController, type: :controller do
  render_views
  before :each do
    @user = create :user, full_name: "John Doe"
  end

  # POST /api/v1/lists
  it "should allow a logged in user create a list" do
    post :create,  list: {name: "The first list" }, token: @user.active_api_key.token, format: :json

    list = @user.lists
    resp = JSON.parse(response.body)

    expect(list.empty?).not_to be true
    expect(resp["name"]).to eq "The first list"
  end

  # GET /lists
  it 'should show a list of bucketlists for a user' do
    list = create :list, name: "The first list", user_id: @user.id

    get :show, id: list.id, token: @user.active_api_key.token, format: :json

    list_returned = JSON.parse(response.body)

    expect(list_returned["name"]).to eq "The first list"
    expect(list_returned["created_by"]).to eq @user.full_name
  end


  # PATCH /api/v1/users/1
  it "should edit a list for a logged in user" do
    original_list = create(:list, user_id: @user.id)

    expect(original_list["name"]).not_to eq "The first edited list"

    patch :update, id: original_list.id, list: {name: "The first edited list"}, token: @user.active_api_key.token, format: :json
    edited_list = List.find_by_id(original_list.id)

    expect(edited_list["name"]).not_to eq original_list["name"]
    expect(edited_list["name"]).to eq "The first edited list"
  end

  # PATCH /api/v1/users/1
  it "should not edit a list for a non-logged in user" do
    original_list = create(:list, user_id: @user.id, name: "The first list")

    expect(original_list["name"]).to eq "The first list"

    patch :update, id: original_list.id, list: {name: "The first edited list"}, format: :json
    edited_list = List.find_by_id(original_list.id)

    expect(edited_list["name"]).not_to eq "The first edited list"
    expect(edited_list["name"]).to eq original_list["name"]
  end

  # DELETE /api/v1/users
  it "should delete a list for a logged in user" do
    list = create(:list, user_id: @user.id)

    expect(@user.lists.empty?).not_to be true

    delete :destroy, id: list.id, token: @user.active_api_key.token

    expect(@user.lists.empty?).to be true
  end

  # DELETE /api/v1/users
  it "should not delete a list for a non-logged in user" do
    list = create(:list, user_id: @user.id)

    expect(@user.lists.empty?).not_to be true

    # no token supplied
    delete :destroy, id: list.id

    expect(@user.lists.empty?).not_to be true
  end

end
