class CreateProductItems < ActiveRecord::Migration[7.0]
  def change
    create_table :product_items do |t|
      t.integer :quantity
      t.references :product, null: false, foreign_key: true
      t.references :client, null: false, foreign_key: true

      t.timestamps
    end
  end
end
