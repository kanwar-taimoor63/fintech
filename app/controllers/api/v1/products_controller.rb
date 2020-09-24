module Api::V1
  class ProductsController < ApplicationController
   
    def index
      @products = Product.search(params[:search])
      render json: @products
    end

  end
end
