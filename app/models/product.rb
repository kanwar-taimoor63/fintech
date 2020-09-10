class Product < ApplicationRecord
  belongs_to :category

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
    where('products.id LIKE ? || products.title LIKE ? || products.status LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%")
  end

  STATUS = {
    publish: "publish",
    draft: "draft",
    pending: "pending"
  }.freeze
  enum status: STATUS

end
