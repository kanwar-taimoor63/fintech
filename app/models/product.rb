class Product < ApplicationRecord
  validates_uniqueness_of :title

  has_one_attached :image
  has_and_belongs_to_many :coupons, optional: true
  belongs_to :category
  has_many :order_items, dependent: :destroy

  validates :description, length: { maximum: 60_000 }
  validates :title, :status, presence: true, length: { maximum: 250 }
  validates :price, presence: true, format: { with: /\A\d+(?:\.\d{0,2})?\z/ }, numericality: { greater_than: 0, less_than: 100_000_000 }
  PRODUCT_STATUS='publish'

  def price_with_discount
    return self.price if self.discount_price.nil? || self.discount_price <= 0 || self.expiry_date.nil? || (self.expiry_date < Date.today)

    return self.discount_price
  end

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
