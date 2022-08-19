class ProductItemsController < ApplicationController
  before_action :authenticate_client!

  def create
    product_id = params[:product_id]
    @item = ProductItem.find_by(product_id:)
    @stock = StockProduct.where(product_id:)

    if @stock&.any?
      ProductItemService.create_or_increment(@item, product_id, current_client)
      redirect_to shopping_cart_path, notice: 'Produto adicionado ao carrinho!'
    else
      redirect_to product_path(product_id)
    end
  end

  def increment_quantity
    product_id = params[:product_id]
    @item = ProductItem.find_by(product_id:)
    if ProductItemService.check_stock(product_id, @item.quantity)
      redirect_to shopping_cart_path, notice: 'Não há mais produtos em estoque'
      return
    end
    @item.quantity += 1
    @item.save
    redirect_to shopping_cart_path
  end

  def decrement_quantity
    product_id = params[:product_id]
    @item = ProductItem.find_by(product_id:)
    @item.quantity -= 1
    @item.save
    redirect_to shopping_cart_path
  end
end
