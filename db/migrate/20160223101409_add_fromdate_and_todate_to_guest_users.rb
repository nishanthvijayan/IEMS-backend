class AddFromdateAndTodateToGuestUsers < ActiveRecord::Migration
  def change
    add_column :guest_users, :from_date, :date
    add_column :guest_users, :to_date, :date
  end
end
