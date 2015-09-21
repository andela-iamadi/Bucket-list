require 'rails_helper'

describe User, type: :controller do

  before :each do
    # create :item
    # create :list
    # create :user
    # User.last.items << Item.last
    # Item.last.lists << List.last
  end

  # GET /tasks/:id
  it 'should return a list of Users' do
    user = build(:user, full_name: "Joe");

    require 'pry-nav'; binding.pry

    get api_v1_users_path

    user = JSON.parse(response.body)
    expect(user.first_name).to eq "Joe"
  end
end
