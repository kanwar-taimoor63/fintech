module Admin
  class ProductsController < BaseController
    before_action :set_product, only: %i[show edit update destroy]

    def index
      @pagys, @products = pagy(Product.all, items: 5)
      if params[:search].present?
        @pagys, @products = pagy(Product.search(params[:search]), items: 5)
        @pagys, @products = pagy(@products.order(sort_column(@products) + ' ' + sort_direction), items: 5) if sort_column(@products).present? && sort_direction.present?
      else
        @pagys, @products = pagy(@products.order(sort_column(@products) + ' ' + sort_direction),items: 5) if sort_column(@products).present? && sort_direction.present?
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
      redirect_to admin_categories_path
    end

    private

    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:title, :price, :description, :status, :category_id)
    end

  end
end

