class CheckoutsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_checkout, only: %i[show]

  def index
    @carts = current_user.checkouts
  end

  def show

  end

  def create
    @checkout = current_user.checkouts.new
    @carts = current_user.pending_carts.includes(:product)
    @total_amount = 0
    @carts.each do |cart|
      @total_amount += cart.purchase_count * cart.product.price
    end
    ActiveRecord::Base.transaction do
      @checkout.total_amount = @total_amount
      if @checkout.save!
        @carts.each do |cart|
          product = cart.product
          if product.stock_count >= cart.purchase_count
            product.update!(stock_count: product.stock_count - cart.purchase_count)
            cart.update!(checkout_id: @checkout.id)
          else
            redirect_to carts_url, :alert => "#{product.name} doesn't have enought stock."
            raise ActiveRecord::Rollback
          end
        end
        redirect_to root_url
      end
    end
  end

  private
    def set_checkout
      @checkout = Checkout.find(params[:id])
    end
end
