class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show ]

  # GET /products or /products.json
  def index
    keyword = params[:search_key]
    @products = Product.with_stocks
    if keyword
      @products = @products.where("LOWER(products.name) LIKE LOWER(?) or LOWER(products.sku) LIKE LOWER(?)","%#{keyword}%", "%#{keyword}%")
    end
    @products = @products.order(:id).page(params[:page] || 1).per(12)
  end

  # GET /products/1 or /products/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end
end
