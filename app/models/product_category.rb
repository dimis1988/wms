class ProductCategory < ApplicationRecord
    has_many :products, dependent: :destroy
    has_one_attached :image
    before_save :capitalize_name 
    default_scope { order('created_at DESC') }

    def capitalize_name
      self.name = name.capitalize
    end
end
