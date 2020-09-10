class Product < ApplicationRecord
  belongs_to :category
  PER_PAGE = 5

  def self.to_csv
    attributes = %w[id title]

    CSV.generate(headers: true) do |csv|
      csv << attributes

      find_each do |product|
        csv << attributes.map { |attr| product.send(attr) }
      end
    end
  end

  def self.search(search)
    return all if search.blank?

    where('products.id LIKE ? OR products.title LIKE ? OR products.status LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%")
  end

  STATUS = {
    publish: "publish",
    draft: "draft",
    pending: "pending"
  }.freeze
  enum status: STATUS

end
