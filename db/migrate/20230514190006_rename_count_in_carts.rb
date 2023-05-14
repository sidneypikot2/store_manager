class RenameCountInCarts < ActiveRecord::Migration[7.0]
  def up
    rename_column :carts, :count, :purchase_count
  end
  def down
    rename_column :carts, :purchase_count, :count
  end
end
