class ProductsController < ApplicationController
  before_action :set_product, only: %i[show]

  def index
   @pagys, @products = pagy(Product.search(params[:search]), items: Product::PER_PAGE)
   @order_item = current_order.order_items.new
  end

  def show
    @order_item = current_order.order_items.new
   end
    
  private

  def set_product
    @product = Product.find(params[:id])
  end
end
