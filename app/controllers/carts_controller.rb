class CartsController < ApplicationController
  before_action :set_cart, only: %i[destroy]
  def index
    @carts = current_user.carts.includes(:product)
    @checkout = Checkout.new
    @total_amount = 0
    @carts.each do |cart|
      @total_amount += cart.count * cart.product.price
    end
  end

  def create
    @cart = current_user.carts.where(product_id: cart_params.dig(:product_id)).first
    if @cart.present?
      @cart.count += 1
      @cart.save
    else
      @cart = current_user.carts.build(cart_params)
      if @cart.valid?
        @cart.save
      else
        head :no_content
      end
    end
    head :no_content
  end

  def destroy
    if @cart.destroy
      redirect_to carts_url
    else
      head :no_content
    end
  end
  private

    def set_cart
      @cart = Cart.find(params[:id])
    end
    # Only allow a list of trusted parameters through.
    def cart_params
      params.require(:cart).permit(:product_id, :count)
    end
end
