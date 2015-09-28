require 'rails_helper'

describe Api::V1::ItemsController, type: :controller do
  render_views

  before :each do
    @user = create :user, full_name: "John Doe"
    @list = create(:list, user_id: @user.id)
  end

  # GET /api/v1/lists/:id/items
  it 'should show a list of items in a list' do
    item1 = create :item, name: "The first item", list_id: @list.id
    item2 = create :item, name: "The second item", list_id: @list.id

    get :index, list_id: @list.id, token: @user.active_api_key.token, format: :json

    items_returned = JSON.parse(response.body)

    expect(items_returned["items"][0]["name"]).to eq item1.name
    expect(items_returned["items"][1]["name"]).to eq item2.name
  end

  # POST /api/v1/lists/:id/items
  it "should allow a logged in user create an item" do
    post :create, list_id: @list.id,  item: {name: "The first item" }, token: @user.active_api_key.token, format: :json

    list = @user.lists
    expect(list.empty?).not_to be true

    resp = JSON.parse(response.body)

    expect(resp["name"]).to eq "The first item"
  end

  # SHOW /api/v1/lists/:id/items/:id
  it 'should return a single item in a list' do
    item1 = create :item, name: "The first item", list_id: @list.id
    item2 = create :item, name: "The second item", list_id: @list.id

    get :show, list_id: @list.id, id: item2.id, token: @user.active_api_key.token, format: :json

    items_returned = JSON.parse(response.body)

    expect(items_returned["name"]).to eq item2.name
  end

  # PATCH /api/v1/lists/:id/items/:id
  it "should edit an item" do
    original_item = create(:item, list_id: @list.id)

    expect(original_item["name"]).not_to eq "The first edited item"

    patch :update, id: original_item.id, list_id: @list.id, item: {name: "The first edited item"}, token: @user.active_api_key.token, format: :json
    edited_item = Item.find_by_id(original_item.id)

    expect(edited_item["name"]).not_to eq original_item["name"]
    expect(edited_item["name"]).to eq "The first edited item"
  end

  # DELETE /api/v1/lists/:id/items/:id
  it "should delete an item" do
    item = create(:item, list_id: @list.id)

    expect(@list.items.empty?).not_to be true

    delete :destroy, id: item.id, list_id: @list.id, token: @user.active_api_key.token

    expect(@list.items.empty?).to be true
  end

end
