class ShoppingCartController < ApplicationController
  before_action :authenticate_client!

  def index
    @product_items = ProductItem.where(client: current_client)
  end
end
