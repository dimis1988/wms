class CreateProductCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :product_categories do |t|
      t.string :name

      t.timestamps
    end
    add_index :product_categories, :name, unique: true
  end
end
