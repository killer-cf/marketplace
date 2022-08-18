class ProductItem < ApplicationRecord
  belongs_to :product
  belongs_to :client

  def subtotal
    quantity * product.price
  end
end
