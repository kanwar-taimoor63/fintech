class Category < ApplicationRecord
  validates :name, presence: true, length: { maximum: 250 }, uniqueness: { case_sensitive: false }
  has_many :products, dependent: :destroy
  def self.csv_attr
    %w[id name]
  end

  def self.search(search)
    return all if search.blank?

    where('categories.id LIKE ? OR categories.name LIKE ?', "%#{search}%", "%#{search}%")
  end
end
