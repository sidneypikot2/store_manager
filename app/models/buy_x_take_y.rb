class BuyXTakeY < ApplicationRecord
  belongs_to :promotion
  belongs_to :product

  validates_presence_of :buy_x_condition
end
