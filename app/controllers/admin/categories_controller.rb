module Admin
  class CategoriesController < Admin::BaseController
    before_action :set_category, only: %i[show edit destroy update]

    def index
      @pagy, @categories = pagy(Category.search(params[:search]), items: Category::PER_PAGE)
        if sort_column(@categories).present? && sort_direction.present?
          @pagys, @categories = pagy(@categories.order(sort_column(@categories) + ' ' + sort_direction), items: Category::PER_PAGE)
        end
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
      if @category.save
        redirect_to url: [:admin, @category], notice: 'Category was successfully created.'
      else
        render :new
      end
    end

    def edit; end

    def update
      if @category.update(category_params)
        redirect_to url: [:admin, @category], notice: 'Category was successfully updated.'

      else
        render :edit

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
      @category = begin
                    Category.find(params[:id])
                  rescue StandardError
                    nil
                  end
    end

    def category_params
      params.require(:category).permit(:name)
    end

  end
end
