class Admin::ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]

  # GET /products or /products.json
  def index
    keyword = params[:search_key]
    @products = Product.all
    if keyword
      @products = @products.where("LOWER(products.name) LIKE LOWER(?) or LOWER(products.sku) LIKE LOWER(?)","%#{keyword}%", "%#{keyword}%")
    end
    @products = @products.order(:id).page(params[:page] || 1).per(10)
  end

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
    @product.promotion_type = nil if @product.promotion_type.nil?
    @product.build_promotion
    @product.promotion.build_buy_x_take_y
    @product.promotion.build_buy_x_discount
  end

  # GET /products/1/edit
  def edit
    @product.build_promotion if @product.promotion.nil?
    @product.promotion.build_buy_x_take_y if @product.promotion.buy_x_take_y.nil?
    @product.promotion.build_buy_x_discount if @product.promotion.buy_x_discount.nil?
    if !@product.promotion.nil? && !@product.promotion.new_record?
      if !@product.promotion.buy_x_take_y.nil? && !@product.promotion.buy_x_take_y.new_record?
        @product.promotion_type = "buy_x_take_y"
      elsif !@product.promotion.buy_x_discount.nil? && !@product.promotion.buy_x_discount.new_record?
        @product.promotion_type = "buy_x_discount"
      else
        @product.promotion_type = nil if @product.promotion_type.nil?
      end
    else
      @product.promotion_type = nil if @product.promotion_type.nil?
    end
  end

  # POST /products or /products.json
  def create
    if product_permitted_params[:with_promotion] == "0"
      @product = Product.new(product_permitted_params.except(:promotion_attributes))
    else
      @product = Product.new(product_permitted_params)
    end
    product_params = product_permitted_params.except(:promotion_attributes)
    if product_permitted_params[:with_promotion] == "0"
      @product = Product.new(product_params)
    else
      if product_permitted_params[:promotion_type] == "buy_x_take_y"
        promotion_attributes = product_permitted_params[:promotion_attributes].except(:buy_x_discount_attributes)
        @product = Product.new(product_params.merge({promotion_attributes: promotion_attributes}))
      else
        promotion_attributes = product_permitted_params[:promotion_attributes].except(:buy_x_take_y_attributes)
        @product = Product.new(product_params.merge({promotion_attributes: promotion_attributes}))
      end
    end
    respond_to do |format|
      if @product.save
        format.html { redirect_to admin_products_url, notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        @product.build_promotion
        @product.promotion.build_buy_x_take_y
        @product.promotion.build_buy_x_discount
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    product_params = product_permitted_params.except(:promotion_attributes)
    if product_permitted_params[:with_promotion] == "0"
      is_updated = @product.update(product_params)
    else
      if product_permitted_params[:promotion_type] == "buy_x_take_y"
        promotion_attributes = product_permitted_params[:promotion_attributes].except(:buy_x_discount_attributes)
        is_updated = @product.update!(product_params.merge({promotion_attributes: promotion_attributes}))
      else
        promotion_attributes = product_permitted_params[:promotion_attributes].except(:buy_x_take_y_attributes)
        is_updated = @product.update!(product_params.merge({promotion_attributes: promotion_attributes}))
      end
    end
    respond_to do |format|
      if is_updated
        format.html { redirect_to admin_products_url, notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        @product.build_promotion
        @product.promotion.build_buy_x_take_y
        @product.promotion.build_buy_x_discount
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy

    respond_to do |format|
      format.html { redirect_to admin_products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_permitted_params
      params.require(:product).permit(:name, :sku, :stock_count, :price, :id, :with_promotion, :promotion_type,
        promotion_attributes: [:status, :name, :_destroy, :id,
          buy_x_take_y_attributes: [ :product_id, :buy_x_condition, :id ],
          buy_x_discount_attributes: [ :buy_x_condition, :discount_percent, :discount_price, :id ]])
    end
end
