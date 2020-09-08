module Admin
  class CategoriesController < Admin::BaseController
    before_action :set_category, only: %i[show edit destroy update]

    def index
      @pagy, @category = pagy(Category.all, items: 5)
      respond_to do |format|
        format.html
        format.csv { send_data Category.all.to_csv, filename: "categories-#{Date.today}.csv" }
      end
    end

    def show; end

    def new
      @category = Category.new
    end

    def create
      @category = Category.new(category_params)
      respond_to do |format|
        if @category.save
          format.html { redirect_to url: [:admin, @category], notice: 'Category was successfully created.' }
        else
          format.html { render :new }

        end
      end
    end

    def edit; end

    def update
      respond_to do |format|
        if @category.update(category_params)
          format.html { redirect_to url: [:admin, @category], notice: 'Category was successfully updated.' }

        else
          format.html { render :edit }

        end
      end
  end

    def destroy
      if @category.destroy
        flash[:notice] = 'Category has been deleted'
      else
        flash[:alert] = 'Unable to delete category'
      end
      redirect_to admin_categories_path
    end

  private

    def set_category
      @category = Category.find(params[:id])
     end

    def category_params
      params.require(:category).permit(:name)
    end

    def not_found
      raise ActionController::RoutingError, 'Not Found'
  end
end
end
