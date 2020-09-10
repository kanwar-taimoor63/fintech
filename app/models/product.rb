class Product < ApplicationRecord
  has_and_belongs_to_many :coupons, optional: true
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

  STATUS = {
    publish: "publish",
    draft: "draft",
    pending: "pending"
  }.freeze
  enum status: STATUS

end
