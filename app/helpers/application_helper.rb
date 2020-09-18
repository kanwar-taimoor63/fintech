module ApplicationHelper
  include Pagy::Frontend

  def sortable(column, title = nil, temp)
    title ||= column.titleize
    css_class = column == sort_column(temp) ? "current #{sort_direction}" : nil
    direction = column == sort_column(temp) && sort_direction == 'desc' ? 'asc' : 'desc'
    link_to title, { sort: column, direction: direction, search: params[:search] }, { class: 'text-white' }
  end

  def current_order
    if session[:order_id].present?
      begin
        Order.find(session[:order_id])
      rescue StandardError
        Order.new
      end
      
    else
      Order.new
    end
  end
end
