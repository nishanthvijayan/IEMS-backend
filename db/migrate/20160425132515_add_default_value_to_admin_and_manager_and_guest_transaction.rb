class AddDefaultValueToAdminAndManagerAndGuestTransaction < ActiveRecord::Migration
  def up
    change_column :regular_users, :admin, :boolean, :default => false
    change_column :regular_users, :manager, :boolean, :default => false
    change_column :transactions, :guest_transaction, :boolean, :default => false
  end

  def down
    change_column :regular_users, :admin, :boolean, :default => nil
    change_column :regular_users, :manager, :boolean, :default => nil
    change_column :transactions, :guest_transaction, :boolean, :default => nil
  end
end
