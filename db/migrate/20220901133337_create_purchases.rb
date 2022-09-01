class CreatePurchases < ActiveRecord::Migration[7.0]
  def change
    create_table :purchases do |t|
      t.string :cpf
      t.string :order
      t.decimal :value
      t.string :card_number
      t.references :client, null: false, foreign_key: true

      t.timestamps
    end
  end
end
