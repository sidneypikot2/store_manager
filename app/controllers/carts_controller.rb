class CartsController < ApplicationController

  def index
    @carts = current_user.carts
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

  private

    # Only allow a list of trusted parameters through.
    def cart_params
      params.require(:cart).permit(:product_id, :count)
    end
end
