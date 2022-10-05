class RemoveNullClientOfProductItem < ActiveRecord::Migration[7.0]
  def change
    change_column_null :product_items, :client_id, true
  end
end
