class Category < ApplicationRecord
  has_many :products

  def self.to_csv
    attributes = %w[id name]

    CSV.generate(headers: true) do |csv|
      csv << attributes

      find_each do |category|
        csv << attributes.map { |attr| category.send(attr) }
      end
    end
  end
end
