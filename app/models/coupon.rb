class Coupon < ApplicationRecord
  def self.search(search)
    where('coupons.name LIKE ? OR coupons.id LIKE ? OR coupons.value LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%")
  end
  def self.to_csv
    attributes = %w[id name value]

    CSV.generate(headers: true) do |csv|
      csv << attributes

      find_each do |coupon|
        csv << attributes.map { |attr| coupon.send(attr) }
      end
    end
  end
end
