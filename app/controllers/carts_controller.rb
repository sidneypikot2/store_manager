class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart, only: %i[destroy]
  def index
    @carts = current_user.pending_carts.includes(product: [promotion: [:buy_x_discount, :buy_x_take_y]])
    @checkout = Checkout.new
    @total_amount = 0
    @carts.each do |cart|
      cart.sub_total = cart.purchase_count * cart.product.price
      promotion = cart.product.promotion
      # if promotion is present
      if promotion.present?
        # if promotion type is discount
        if promotion.buy_x_discount.present? && promotion.buy_x_discount&.buy_x_condition <= cart.purchase_count
          @total_amount += cart.purchase_count * promotion.buy_x_discount.discount_price
          cart.discounted_total = cart.purchase_count * promotion.buy_x_discount.discount_price
        # if promotion type is buy x take y
        elsif promotion.buy_x_take_y.present? && promotion.buy_x_take_y.buy_x_condition <= cart.purchase_count
          # if buy_x product is also take_y product
          if promotion.buy_x_take_y.product_id == cart.product_id
            if promotion.buy_x_take_y.buy_x_condition == cart.purchase_count
              cart.purchase_count = cart.purchase_count + 1
            end
            new_cart_count = cart.purchase_count - (cart.purchase_count / promotion.buy_x_take_y.buy_x_condition)
            @total_amount += new_cart_count * cart.product.price
            cart.discounted_total = new_cart_count * cart.product.price
          else
            @total_amount += cart.purchase_count * cart.product.price
          end
        # if promotion is present but no condition is met
        else
          @total_amount += cart.purchase_count * cart.product.price
        end
      else
        # if product belongs to take_y promotion
        buy_x_take_y_of_cart = BuyXTakeY.includes(promotion: :product).where(product_id: cart.product_id).where(promotion: {product_id: @carts.pluck(:product_id)}).first
        if buy_x_take_y_of_cart.present?
          promoted_cart = @carts.where(product_id: buy_x_take_y_of_cart.promotion.product.id).first
          if promoted_cart.purchase_count >= buy_x_take_y_of_cart.buy_x_condition
            promotion_applied_count = promoted_cart.purchase_count / buy_x_take_y_of_cart.buy_x_condition
            if cart.purchase_count - promotion_applied_count < 0
              cart.purchase_count = cart.purchase_count - (cart.purchase_count - promotion_applied_count)
            end
            cart.discounted_total = 0
          else
            @total_amount += cart.purchase_count * cart.product.price
          end
        # if no promotion is present & no product on take_y promotion
        else
          @total_amount += cart.purchase_count * cart.product.price
        end
      end
    end
  end

  def create
    @cart = current_user.pending_carts.where(product_id: cart_params.dig(:product_id)).first
    if @cart.present?
      @cart.purchase_count += 1
      @cart.save
    else
      @cart = current_user.carts.build(cart_params)
      if @cart.valid?
        @cart.save
      else
        head :no_content
      end
    end
    redirect_to root_url
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
      params.require(:cart).permit(:product_id, :purchase_count)
    end
end
