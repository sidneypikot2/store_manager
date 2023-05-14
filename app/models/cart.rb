class Cart < ApplicationRecord
  attr_accessor :sub_total, :discounted_total

  belongs_to :user
  belongs_to :product

  validates_presence_of :user, :product, :purchase_count

  scope :pending_carts, -> { where(checkout_id: nil) }
end
