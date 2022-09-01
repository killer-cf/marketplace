class TransactionService
  def self.send(card_params, current_client)
    json_data = { transaction: card_params.merge(order: current_client.purchases.last.order,
                                                 value: current_client.cart_total_value.to_f) }.to_json(except: :client_id)
    Faraday.post('http://localhost:4000/api/v1/transactions', json_data, content_type: 'application/json')
  end

  def self.change_status(purchase, response)
    purchase.approved! if response.body[:status] == 'accepted'
    purchase.rejected! if response.body[:status] == 'rejected'
  end

  def self.card_valid?(card_params)
    card = Card.new(card_params)
    card.valid?
  end
end
