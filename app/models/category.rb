class Category < ApplicationRecord
  has_many :products
  
  def self.csv_attr
    %w[id name]
  end
end
