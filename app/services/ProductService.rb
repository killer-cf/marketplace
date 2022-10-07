class ProductService
  def self.stock?(product_items)
    item_available = []
    product_items.each do |product_item|
      stock = StockProduct.where(product_id: product_item.product.id)
      if stock.count < product_item.quantity
        product_item.quantity = stock.count
        product_item.save
        item_available << false
      end
    end
    item_available.include?(false) ? false : true
  end
end
