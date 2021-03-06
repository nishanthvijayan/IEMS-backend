class Transaction < ActiveRecord::Base
  has_paper_trail

  mount_uploader :image, ProofImageUploader

  belongs_to :regular_user
  belongs_to :guest_user

  before_save :set_billed_user

  validates :food_type, presence: true,
                        inclusion: { in: %w(B L D S), message: '%{value} is not a valid food type' }
  validates :date,  presence: true
  validates :price, presence: true,
                    numericality: true

  validate :presence_of_proper_user_id

  def presence_of_proper_user_id
    if guest_transaction
      errors.add(:guest_user_id, 'cannot be empty for a guest transaction') unless guest_user_id?
    else
      errors.add(:regular_user_id, 'cannot be empty for a regular transaction') unless regular_user_id?
    end
  end

  def self.to_csv
    CSV.generate do |csv|
      csv << %w(ID Guest_Transaction? Guest_Name Regular_User Food_Type Price Date)
      find_each do |transaction|
        csv << [transaction.id, transaction.guest_transaction?, transaction.guest_transaction? ? transaction.guest_user.name : '-',
                transaction.regular_user.name, transaction.food_type, transaction.price, transaction.date]
      end
    end
  end

  def set_billed_user
    return unless guest_transaction?
    self.regular_user = guest_user.host_user
  end
end
