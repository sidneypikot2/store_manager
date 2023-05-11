class Product < ApplicationRecord

  has_many :carts

  validates_presence_of :sku, :name, :price, :stock_count
  validates_uniqueness_of :sku
  validates :stock_count, numericality: { only_integer: true }

  before_create :add_image_url

  scope :with_stocks, -> { where.not(stock_count: 0)}

  private

  def add_image_url
    self.image_url = "https://loremflickr.com/400/400"
  end
end
