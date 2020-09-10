class Category < ApplicationRecord
  has_many :products, dependent: :destroy
  PER_PAGE = 5

  def self.to_csv
    attributes = %w[id name]

    CSV.generate(headers: true) do |csv|
      csv << attributes

      find_each do |category|
        csv << attributes.map { |attr| category.send(attr) }
      end
    end
  end

  def self.search(search)
    return all if search.blank?

    where('categories.id LIKE ? OR categories.name LIKE ?', "%#{search}%", "%#{search}%")
  end

end
