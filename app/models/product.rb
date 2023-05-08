class Product < ApplicationRecord

  validates_presence_of :sku, :name, :price, :stock_count
  validates_uniqueness_of :sku
  validates :stock_count, numericality: { only_integer: true }
end
