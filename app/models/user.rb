class User < ActiveRecord::Base
  has_many :items, dependent: :destroy
  has_many :lists, through: :items, dependent: :destroy
  has_one :api_key, dependent: :destroy
  after_create :create_api_key
  has_secure_password


  validates :full_name,  presence: true, length: { maximum: 150 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }, allow_blank: true
  private

  def create_api_key
    ApiKey.create :user_id => self.id
  end
end
