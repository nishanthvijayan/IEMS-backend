class CreateSingleValues < ActiveRecord::Migration
  def change
    create_table :single_values do |t|
      t.string :key
      t.string :value

      t.timestamps null: false
    end
  end
end
