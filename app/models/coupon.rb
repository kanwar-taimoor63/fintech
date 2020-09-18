class Coupon < ApplicationRecord
  has_and_belongs_to_many :products

  validates :name, presence: true, length: { maximum: 250 }, uniqueness: true
  validates :value, presence: true, format: { with: /\A\d+(?:\.\d{0,2})?\z/ }, numericality: { greater_than: 0, less_than: 100000000 }
  
  def self.search(search)
    return all if search.blank?
    where('coupons.name LIKE ? OR coupons.id LIKE ? OR coupons.value LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%")
  end

  def self.csv_attr
    %w[id name value]
  end
end
