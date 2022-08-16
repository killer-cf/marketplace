class ProductItemsController < ApplicationController
  before_action :authenticate_client!

  def create
    @product_item = ProductItem.new(product_id: params[:product_id], client: current_client, quantity: 1)
    if @product_item.save
      redirect_to shopping_cart_path, notice: 'Produto adicionado ao carrinho!'
    end
  end
end
