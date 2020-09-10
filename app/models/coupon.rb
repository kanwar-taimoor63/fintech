class Coupon < ApplicationRecord
  has_and_belongs_to_many :products
  validates_associated :products
  self.PER_PAGE=5
  def self.search(search)
    return all if search.blank?
    where('coupons.name LIKE ? OR coupons.id LIKE ? OR coupons.value LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%")
  end

  def self.csv_attr
    %w[id name value]
  end
end
