class Promotion < ApplicationRecord
  belongs_to :product
  has_one    :buy_x_discount, dependent: :destroy
  has_one    :buy_x_take_y, dependent: :destroy

  validates_presence_of :name, :status

  accepts_nested_attributes_for :buy_x_discount, allow_destroy: true
  accepts_nested_attributes_for :buy_x_take_y, allow_destroy: true

  def is_active?
    self.status == 'active' && !self.id.nil?
  end
end
