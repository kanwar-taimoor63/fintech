module Orderable
  extend ActiveSupport::Concern

  included do
    def sort_column
      User.column_names.include?(params[:sort]) ? params[:sort] : 'username'
      end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
    end
  end
end
