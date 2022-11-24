class AlterColumnOfAdmin < ActiveRecord::Migration[7.0]
  def change
    change_table :admins do |t|
      t.integer :status, default: 5
    end
  end
end
