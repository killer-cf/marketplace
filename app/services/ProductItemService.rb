class ProductItemService
  def self.create_or_increment(item, id, current_client)
    if item.nil?
      product_item = ProductItem.new(product_id: id, client: current_client, quantity: 1)
      product_item.save
    else
      item.quantity += 1
      item.save
    end
  end
end
