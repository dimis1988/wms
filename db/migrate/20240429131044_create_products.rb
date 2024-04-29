class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.decimal :price, precision: 8, scale: 2
      t.boolean :active, default: true

      t.timestamps
    end
    add_index :products, :name, unique: true
  end
end
