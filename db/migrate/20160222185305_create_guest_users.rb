class CreateGuestUsers < ActiveRecord::Migration
  def change
    create_table :guest_users do |t|
      t.string :name
      t.integer :regular_user_id
      t.string :details
      t.timestamps null: false
    end
  end
end
