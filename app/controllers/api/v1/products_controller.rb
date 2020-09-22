class Api::V1::ProductsController < ApplicationController
 
  def index
   @products = Product.search(params[:search])
   render json: @products
  end

end