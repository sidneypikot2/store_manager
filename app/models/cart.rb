class Cart < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates_presence_of :user, :product, :count

  scope :pending_carts, -> { where(checkout_id: nil) }
end
