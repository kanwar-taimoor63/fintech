module Csvable
  extend ActiveSupport::Concern
  included do
    def self.to_csv
      attributes = csv_attr

      CSV.generate(headers: true) do |csv|
        csv << attributes

        find_each do |record|
          csv << attributes.map { |attr| record.send(attr) }
        end
      end
    end
  end
end
