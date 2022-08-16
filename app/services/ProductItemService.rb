class ProductItemService
  def self.create_or_increment(item, id, current_client)
    if item.empty?
      product_item = ProductItem.new(product_id: id, client: current_client, quantity: 1)
      product_item.save
    else
      item.each { |i| (i.quantity += 1) && i.save }
    end
  end
end
