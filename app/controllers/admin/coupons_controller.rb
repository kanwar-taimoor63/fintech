module Admin
  class CouponsController < Admin::BaseController
    before_action :set_coupons, only: %i[show edit destroy update]

    def index
      @pagy, @coupons = pagy(Coupon.search(params[:search]), items: PER_PAGE)
      if sort_column(@coupons).present? && sort_direction.present?
      @pagy, @coupons= pagy(@coupons.order(sort_column(@coupons) + ' ' + sort_direction), items: PER_PAGE)
      end
      respond_to do |format|
        format.html
        format.csv { send_data Coupon.all.to_csv, filename: "coupons-#{Date.today}.csv" }
      end
    end
  
    def show; end

    def new
      @coupon = Coupon.new
    end

    def create
      @coupon = Coupon.new(coupon_params)
      if @coupon.save
        redirect_to url: [:admin, @coupon], notice: 'Coupon was successfully created.'
      else
        render :new
      end
    end

    def edit; end

    def update
      if @coupon.update(coupon_params)
        redirect_to url: [:admin, @coupon], notice: 'Coupon was successfully updated.'

      else
        render :edit

      end
    end

    def destroy
      if @coupon.destroy
        flash[:notice] = 'Coupon has been deleted'
      else
        flash[:alert] = 'Unable to delete Coupon'
      end
      redirect_to admin_coupons_path
    end

    private

    def set_coupons
      @coupon = Coupon.find(params[:id])
    end

    def coupon_params
      params.require(:coupon).permit(:name, :value, :search, product_ids: [])
    end
  end
end
