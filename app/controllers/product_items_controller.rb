class ProductItemsController < ApplicationController
  before_action :authenticate_client!

  def create
    product_id = params[:product_id]
    @item = ProductItem.find_by(product_id:)
    @stock = StockProduct.where(product_id:)
    puts @stock
    if @stock&.any?
      ProductItemService.create_or_increment(@item, product_id, current_client)
      redirect_to shopping_cart_path, notice: 'Produto adicionado ao carrinho!'
    else
      redirect_to product_path(product_id)
    end
  end
end
