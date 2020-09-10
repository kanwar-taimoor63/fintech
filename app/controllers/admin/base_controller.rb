class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  layout 'admin'
  include Orderable
  helper_method :sort_column, :sort_direction
  PER_PAGE=5
end
