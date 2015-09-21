class Item < ActiveRecord::Base
  has_many :lists, :dependent => :destroy
  belongs_to :user
end
