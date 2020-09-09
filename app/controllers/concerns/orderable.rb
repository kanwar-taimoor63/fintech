module Orderable
  extend ActiveSupport::Concern

  included do
    def sort_column(usertg)
      usertg.column_names.include?(params[:sort]) ? params[:sort] : ''
      end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : ''
    end
  end
end
