class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  PER_PAGE=5
  include Csvable
  def self.csv_attr;end
end
