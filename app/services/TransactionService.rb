class TransactionService
  def self.send(card_params, current_client)
    json_data = { transaction: card_params.merge(order: current_client.purchases.last.order,
                                                 value: current_client.cart_total_value.to_f) }.to_json(except: :client_id)
    Faraday.post('http://localhost:4000/api/v1/transactions', json_data, content_type: 'application/json')
  rescue Faraday::ConnectionFailed
    nil
  end

  def self.change_status(purchase, response)
    if response['status'] == 'accepted'
      purchase.approved!
      purchase.client.product_items.clear
      purchase.product_items.each do |product_item|
        product_item.quantity.times { product_item.product.stock_products.last.destroy }
      end
    end
    purchase.rejected! if response['status'] == 'rejected'
  end
end
