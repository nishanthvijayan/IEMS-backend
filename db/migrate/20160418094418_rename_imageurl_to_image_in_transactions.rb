class RenameImageurlToImageInTransactions < ActiveRecord::Migration
  def change
    rename_column :transactions, :image_url, :image
  end
end
