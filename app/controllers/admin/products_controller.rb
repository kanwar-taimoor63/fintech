module Admin
  class ProductsController < BaseController
    before_action :set_product, only: %i[show edit update destroy discount]

    def index
      @pagy, @products = pagy(Product.search(params[:search]), items: Product::PER_PAGE)
      if sort_column(@products).present? && sort_direction.present?
        @products = @products.order(sort_column(@products) + ' ' + sort_direction)
      end
      respond_to do |format|
        format.html
        format.csv { send_data Product.all.to_csv, filename: "Products-#{Date.today}.csv" }
      end
    end

    def show; end

    def new
      @product = Product.new
    end

    def create
      @product = Product.new(product_params)
      if @product.save
        redirect_to url: [:admin, @product], notice: 'Product was successfully created.'
      else
        render :new
      end
    end

    def edit; end

    def update
      if @product.update(product_params)
        redirect_to url: [:admin, @product], notice: 'Product was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      if @product.destroy
        flash[:notice] = 'Product has been deleted'
      else
        flash[:alert] = 'Unable to delete product'
      end
      redirect_to admin_products_path
    end

    private

    def set_product
      @product = Product.find(params[:id])           
    end

    def product_params
      if params[:product][:discount_price].present? && params[:product][:expiry_date].present?
        params.require(:product).permit(:title, :price, :discount_price, :expiry_date, :image, :description, :status, :category_id, coupon_ids:[])
      else
        params.require(:product).permit(:title, :price, :image, :description, :status, :category_id, coupon_ids:[])
      end
    end
  end
end
