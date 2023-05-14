class AddImageUrlToProducts < ActiveRecord::Migration[7.0]
  def up
    add_column :products, :image_url, :string
  end
  def down
    remove_column :products, :image_url, :string
  end
end
