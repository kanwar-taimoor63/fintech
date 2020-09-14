class ProductsController < ApplicationController
  before_action :set_product, only: %i[show]
  before_action :set_user, only: %i[index]
  
  def index
    @pagys, @products = pagy(Product.where(status: Product::PRODUCT_STATUS), items: Product::PER_PAGE)
  end

  def show; end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def set_user
    @user = current_user.id
  end
end
