class Order < ApplicationRecord
    has_many :line_items, dependent: :destroy
    belongs_to :user, optional: true
    default_scope { order('created_at DESC') }
    enum :status, { ordered: 0, proceeded: 1, cancelled: 2, refunded: 3, paid: 4 }

    def self.all_order_status
      statuses.keys
    end

    def add_line_items_from_cart(cart)
      cart.line_items.each do |item|
        item.cart_id = nil 
        line_items << item
      end
    end

    def self.ransackable_attributes(auth_object = nil)
      ["created_at", "id", "id_value", "status", "total_price", "updated_at", "user_id"]
      end
end
