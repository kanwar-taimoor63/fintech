module Api::V1
  class ProductsController < BaseController

    def index
      @products = Product.search(params[:search])
      render json: @products
    end

  end
end
