class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :carts, dependent: :destroy
  has_many :pending_carts, -> { pending_carts }, class_name: 'Cart'
  has_many :cart_products, :through => :carts, :source => :product
  has_many :checkouts

  def cart_item_counts
    self.pending_carts.count
  end
end
