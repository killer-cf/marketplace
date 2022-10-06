class ProductService
  def self.stock?(product_items)
    product_items.each do |product_item|
      stock = StockProduct.where(product_id: product_item.product.id)
      return false if stock.count < product_item.quantity
    end
  end
end
