class GuestUser < ActiveRecord::Base
  belongs_to :regular_user
  has_many :transactions
  
  validates :name,  presence: true, 
                             length: { maximum: 40, minimum: 6}
  validates :regular_user_id, presence: true
  validates :to_date, presence: true
  validates :from_date, presence: true
  
  def host_user
    self.regular_user
  end
  
end
