class Cart < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates_presence_of :user, :product, :count
  validates_uniqueness_of :product, scope: :user
end
