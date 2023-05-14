class CreateBuyXTakeIes < ActiveRecord::Migration[7.0]
  def change
    create_table :buy_x_take_ies do |t|
      t.belongs_to :promotion
      t.integer    :buy_x_condition
      t.belongs_to :product
      t.timestamps
    end
  end
end
