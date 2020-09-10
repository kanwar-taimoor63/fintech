class Product < ApplicationRecord
  has_and_belongs_to_many :coupons, optional: true
  belongs_to :category
  validates_associated :coupons
  self.PER_PAGE=5
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
