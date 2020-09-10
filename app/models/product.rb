class Product < ApplicationRecord
  has_and_belongs_to_many :coupons, optional: true
  belongs_to :category

  validates_associated :coupons
  
  def self.csv_attr
    %w[id title]
  end

  def self.search(search)
    return all if search.blank?

    where('products.id LIKE ? OR products.title LIKE ? OR products.status LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%")
  end

  STATUS = {
    publish: 'publish',
    draft: 'draft',
    pending: 'pending'
  }.freeze
  enum status: STATUS
end
