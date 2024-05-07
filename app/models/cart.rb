class Cart < ApplicationRecord
    has_many :line_items, dependent: :destroy

    def add_to_cart(product, quantity)
      item = line_items.find_by(product_id: product.id)
        if item 
            item.quantity += quantity.to_i 
        else
            item = line_items.build(product_id: product.id, quantity: quantity)
        end
        item
    end

    def total_price
      line_items.sum {|line_item| line_item.total_price}
    end
 
end
