class ProductItemsController < ApplicationController
  before_action :authenticate_client!

  def create
    @item = ProductItem.where(product_id: params[:product_id])
    ProductItemService.create_or_increment(@item, params[:product_id], current_client)
    redirect_to shopping_cart_path, notice: 'Produto adicionado ao carrinho!'
  end
end
