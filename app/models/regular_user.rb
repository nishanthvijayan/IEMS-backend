class RegularUser < ActiveRecord::Base
  
  has_many :guest_users
  has_many :transactions

  before_save { self.email = email.downcase }
  validates :name,  presence: true, 
                             length: { maximum: 40, minimum: 6}
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
                           length: { maximum: 100 },
                           format: { with: VALID_EMAIL_REGEX },
                           uniqueness: { case_sensitive: false }
                                  
  has_secure_password
  validates :password, presence: true,
                                  length: { minimum: 6},
                                  allow_blank:  true
 
  private
    # Returns the hash digest of the given string.
    def self.digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                                               BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end                           
end
