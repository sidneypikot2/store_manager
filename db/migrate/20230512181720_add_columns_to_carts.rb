class AddColumnsToCarts < ActiveRecord::Migration[7.0]
  def up
    change_table :carts do |t|
      t.references :checkout, index: true, default: nil
    end
  end

  def down
    change_table :carts do |t|
      t.remove_references :checkout, index: true
    end
  end
end
