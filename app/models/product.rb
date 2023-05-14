class Product < ApplicationRecord
  attr_accessor :with_promotion, :promotion_type
  has_many :carts
  has_one  :promotion, dependent: :destroy

  validates_presence_of :sku, :name, :price, :stock_count
  validates_uniqueness_of :sku
  validates :stock_count, numericality: { only_integer: true }

  before_create :add_image_url

  scope :with_stocks, -> { where.not(stock_count: 0)}

  accepts_nested_attributes_for :promotion, allow_destroy: true

  private
  def add_image_url
    self.image_url = "https://loremflickr.com/400/400"
  end
end
