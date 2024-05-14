class Product < ApplicationRecord
    has_one_attached :image
    before_save :capitalize_name_and_description
    belongs_to :product_category
    has_many :line_items
    has_many :orders, through: :line_items
    default_scope { order('created_at DESC') }

    def capitalize_name_and_description
       self.name = name.capitalize
       self.description = description.capitalize
    end 
end
