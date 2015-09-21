require 'spec_helper'

describe 'Items API', type: :controller do

  before :each do
    # create :item
    # create :list
    # create :item
    # User.last.items << Item.last
    # Item.last.lists << List.last
  end

  # GET /tasks/:id
  it 'should return a list of Items' do
    user = create(:user, full_name: "Chris");
    task = create(:item, user_id: user.id)


    get api_v1_user_items(user)

    user = JSON.parse(response.body)
    expect(user.first_name).to eq "Joe"
  end
end
