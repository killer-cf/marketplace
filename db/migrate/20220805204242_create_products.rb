class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :brand
      t.string :description
      t.string :sku
      t.decimal :price
      t.decimal :width
      t.decimal :height
      t.decimal :depth
      t.decimal :weight
      t.integer :status, default: 1

      t.timestamps
    end
  end
end
