class ProductItem < ApplicationRecord
  belongs_to :product
  belongs_to :client, optional: true
  belongs_to :purchase, optional: true

  before_update :destroy_if_zero

  def subtotal
    quantity * product.price
  end

  def destroy_if_zero
    destroy if quantity.zero?
  end
end
