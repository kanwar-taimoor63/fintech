class PagesController < ApplicationController
 
  def home; end
  
  def policy; end
  def error_404
    render_not_found
  end

end
