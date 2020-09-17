class Coupon < ApplicationRecord
  validates_uniqueness_of :name
  validates :name, presence: true
  validates :value, presence: true
  has_and_belongs_to_many :products
  def self.search(search)
    return all if search.blank?
    where('coupons.name LIKE ? OR coupons.id LIKE ? OR coupons.value LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%")
  end

  def self.csv_attr
    %w[id name value]
  end
end
