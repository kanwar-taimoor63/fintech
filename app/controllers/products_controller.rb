class ProductsController < ApplicationController
  before_action :set_product, only: %i[show]

  def index
    @pagys, @products = pagy(Product.where(status: Product::STATUS[:publish]), items: Product::PER_PAGE)
    @order_item = current_order.order_items.new
  end

  def show; end

  private

  def set_product
    @product = Product.find(params[:id])
  end
end
