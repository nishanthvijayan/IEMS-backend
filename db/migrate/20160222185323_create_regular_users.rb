class CreateRegularUsers < ActiveRecord::Migration
  def change
    create_table :regular_users do |t|
      t.string :name
      t.string :email
      t.boolean :admin
      t.boolean :manager
      t.string :password_digest
      t.string :image_url
      t.timestamps null: false
    end
  end
end
