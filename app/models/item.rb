class Item < ActiveRecord::Base
  has_many :lists, :dependent => :destroy
  belongs_to :user
  default_scope {order("created_at desc")}
end
