class CreateBuyXDiscounts < ActiveRecord::Migration[7.0]
  def change
    create_table :buy_x_discounts do |t|
      t.belongs_to :promotion
      t.integer    :buy_x_condition
      t.decimal    :discount_price, precision: 9, scale: 2
      t.timestamps
    end
  end
end
