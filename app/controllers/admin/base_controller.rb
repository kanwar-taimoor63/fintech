class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  layout 'admin'
  include Orderable
  PER_PAGE=5
  helper_method :sort_column, :sort_direction
end
