class AddNameAndCodeToClient < ActiveRecord::Migration[7.0]
  def change
    add_column :clients, :name, :string
    add_column :clients, :code, :string
  end
end
