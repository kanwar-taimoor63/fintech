class ProductsController < ApplicationController
  before_action :set_product, only: %i[show]
  
  def index
    @pagys, @products = pagy(Product.where(status: Product::PRODUCT_STATUS), items: Product::PER_PAGE)
  end

  def show; end

  private

  def set_product
    @product = Product.find(params[:id])
  end
end
