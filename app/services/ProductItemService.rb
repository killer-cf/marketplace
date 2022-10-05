class ProductItemService
  def self.create_or_increment(item, product_id, client)
    if item.empty?
      product_item = ProductItem.new(product_id:, client:, quantity: 1)
      product_item.save
    else
      item = item.last
      item.quantity += 1
      item.save
    end
  end

  def self.check_stock(product_id, item_quantity)
    stock = StockProduct.where(product_id:)

    stock.count <= item_quantity
  end
end
