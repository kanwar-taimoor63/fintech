class ProductsController < ApplicationController
  before_action :set_product, only: [:show]
  before_action :authenticate_user!

  def index
    @pagys, @products = pagy(Product.where(status: 'publish'), items: Product::PER_PAGE)
  end

  def show; end

  private

  def set_product
    @product = Product.find(params[:id])
  end
end
