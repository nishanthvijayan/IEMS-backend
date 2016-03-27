class Transaction < ActiveRecord::Base
  belongs_to :regular_user
  belongs_to :guest_user

  before_save :set_billed_user

  validates :food_type, presence: true,
                        inclusion: { in: %w(B L D S), message: '%{value} is not a valid food type' }
  validates :date,  presence: true
  validates :price, presence: true,
                    numericality: true

  def set_billed_user
    return unless guest_transaction?
    self.regular_user = guest_user.host_user
  end
end
