module Api::V2
  class ProductsController < Api::BaseController
 
    def index
      @products = Product.all
      render json: @products
    end

  end
end 
