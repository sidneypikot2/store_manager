class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :carts, -> { pending_carts }
  has_many :cart_products, :through => :carts, :source => :product
  has_many :checkouts

  def cart_item_counts
    self.carts.count
  end
end
