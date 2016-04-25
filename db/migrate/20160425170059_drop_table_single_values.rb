class DropTableSingleValues < ActiveRecord::Migration
  def up
    drop_table :single_values
  end

  def down
    create_table :single_values do |t|
      t.string :key
      t.string :value

      t.timestamps null: false
    end
  end
end
