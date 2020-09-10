class PagesController < ApplicationController
  before_action :authenticate_user!, except: [:policy]
 
  def home;end
  def policy; end 
end
