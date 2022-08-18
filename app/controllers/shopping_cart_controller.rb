class ShoppingCartController < ApplicationController
  before_action :authenticate_client!

  def index
    @product_items = ProductItem.where(client: current_client)
    @total = @product_items.sum(&:subtotal)
  end
end
