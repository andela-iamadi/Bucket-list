class List < ActiveRecord::Base
  has_many :items, :dependent => :destroy
  belongs_to :user
  default_scope {order("created_at asc")}
end
