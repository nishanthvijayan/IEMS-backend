class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :guest_user_id
      t.integer :regular_user_id
      t.boolean :guest_transaction
      t.string :food_type
      t.date :date
      t.integer :price
      t.string :image_url
      t.timestamps null: false
    end
  end
end
