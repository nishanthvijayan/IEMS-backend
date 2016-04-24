class GuestUser < ActiveRecord::Base
  has_paper_trail

  belongs_to :regular_user
  has_many :transactions

  validates :name,  presence: true,
                    length: { maximum: 40, minimum: 6}
  validates :regular_user_id, presence: true
  validates :to_date, presence: true
  validates :from_date, presence: true

  def self.to_csv
    CSV.generate do |csv|
      csv << %w(ID Guest_Name Host_Name From_Date To_Date Details)
      find_each do |guest|
        csv << [guest.id, guest.name, guest.host_user.name, guest.from_date, guest.to_date, guest.details]
      end
    end
  end

  def host_user
    regular_user
  end
end
