class ApiKey < ActiveRecord::Base
  belongs_to :user
  before_create :generate_token
  before_create :set_expiration
  before_create :activate
  scope :valid_tokens, -> {where("api_keys.active = ? AND api_keys.expires_at >= ?", true, DateTime.now )}

  def expired?
    DateTime.now >= self.expires_at
  end

  def set_expiration
    self.expires_at = DateTime.now+5
  end

  def activate
    self.active = true
  end

  def deactivate
    self.active = false
  end

  private

  def generate_token
    begin
      self.token = SecureRandom.hex.to_s
    end while self.class.exists?(token: token)
  end
end
