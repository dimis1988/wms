class AddProductCategoryIdToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :product_category_id, :integer
  end
end
