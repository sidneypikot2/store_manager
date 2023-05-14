class CreateCheckouts < ActiveRecord::Migration[7.0]
  def change
    create_table :checkouts do |t|
      t.belongs_to :user
      t.decimal    :total_amount, precision: 9, scale: 2
      t.timestamps
    end
  end
end
