class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
      t.string :password_digest
      t.string :auth_token

      t.timestamps null: false
    end
  end
end
