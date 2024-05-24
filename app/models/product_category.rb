class ProductCategory < ApplicationRecord
    has_many :products, dependent: :destroy
    has_one_attached :image
    before_save :capitalize_name 
    default_scope { order('created_at DESC') }

    def capitalize_name
      self.name = name.capitalize
    end

    def self.ransackable_attributes(auth_object = nil)
      ["active", "created_at", "id", "id_value", "name", "updated_at"]
    end
end
