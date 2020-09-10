class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  layout 'admin'
  include Orderable
  
  helper_method :sort_column, :sort_direction
end
