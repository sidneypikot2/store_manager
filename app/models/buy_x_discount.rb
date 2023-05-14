class BuyXDiscount < ApplicationRecord
  belongs_to :promotion

  validates_presence_of :buy_x_condition, :discount_price
end
