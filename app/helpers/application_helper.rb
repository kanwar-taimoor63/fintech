module ApplicationHelper
  include Pagy::Frontend

  def sortable(column, title = nil, temp)
    title ||= column.titleize
    direction = column == sort_column(temp) && sort_direction == 'desc' ? 'asc' : 'desc'
    link_to title, { sort: column, direction: direction, search: params[:search] }, { class: 'text-white' }
  end
end
