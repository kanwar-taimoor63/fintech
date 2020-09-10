class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  
  include Csvable
  def self.csv_attr;end
end
