class Client < ActiveRecord::Base
  before_create :set_auth_token

  has_secure_password

  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 4 }
  validates :password, presence: true, confirmation: true, length: { minimum: 8 }, allow_blank: true

  private

  def set_auth_token
    return if auth_token.present?
    self.auth_token = generate_auth_token
  end

  def generate_auth_token
    SecureRandom.uuid.gsub(/\-/, '')
  end
end
