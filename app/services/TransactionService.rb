class TransactionService
  def self.send(all_params, order)
    json_data = { transaction: all_params.merge(order:) }.to_json
    Faraday.post('http://localhost:4000/api/v1/transactions', json_data, content_type: 'application/json')
  end

  def self.change_status(purchase, response)
    purchase.approved! if response.body[:status] == 'accepted'
    purchase.rejected! if response.body[:status] == 'rejected'
  end
end
