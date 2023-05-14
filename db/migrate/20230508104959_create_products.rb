class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :sku
      t.string :name
      t.integer :stock_count, defeault: 0
      t.decimal :price, precision: 9, scale: 2
      t.timestamps
    end
  end
end
