class Category < ApplicationRecord
  has_many :products
  PER_PAGE=5
  def self.csv_attr
    %w[id name]
  end
end
