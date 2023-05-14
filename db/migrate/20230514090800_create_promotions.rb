class CreatePromotions < ActiveRecord::Migration[7.0]
  def change
    create_table :promotions do |t|
      t.belongs_to :product
      t.string     :name
      t.string     :status, default: 'active'
      t.timestamps
    end
  end
end
