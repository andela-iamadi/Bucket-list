class User < ActiveRecord::Base
  has_many :lists, dependent: :destroy
  has_many :items, through: :lists, dependent: :destroy
  has_many :api_keys, dependent: :destroy
  after_create :create_api_key
  has_secure_password


  validates :full_name,  presence: true, length: { maximum: 150 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }, allow_blank: true

  def create_api_key
    ApiKey.create :user_id => self.id
  end

  def active_api_key
    api_keys.valid_tokens.first
  end

  def deactivate_tokens
    self.api_keys.each do |key|
      key.active = false
      key.save
    end
  end
end
