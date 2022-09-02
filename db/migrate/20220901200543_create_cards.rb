class CreateCards < ActiveRecord::Migration[7.0]
  def change
    create_table :cards do |t|
      t.string :name
      t.string :cpf
      t.string :number
      t.integer :code
      t.date :valid_date
      t.references :client, null: false, foreign_key: true

      t.timestamps
    end
  end
end