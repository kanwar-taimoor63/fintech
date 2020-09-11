class Product < ApplicationRecord
  has_and_belongs_to_many :coupons, optional: true
  belongs_to :category
  validates_associated :coupons
  PRODUCT_STATUS='publish'
  def self.csv_attr
    %w[id title]
  end

  STATUS = {
    publish: 'publish',
    draft: 'draft',
    pending: 'pending'
  }.freeze
  enum status: STATUS
end
