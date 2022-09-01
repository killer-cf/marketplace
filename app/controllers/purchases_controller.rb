class PurchasesController < ApplicationController
  def new
    @purchase = Purchase.new
  end

  def create
    purchase = Purchase.new(purchase_params)
    if purchase.save
      response = TransactionService.send(transaction_params, current_client.purchases.last.order)
      TransactionService.change_status(purchase, response)
    else

    end
  end

  def purchase_params
    params.require(:purchase).permit(:client_id, :card_number)
          .merge(product_items: current_client.product_items)
  end

  def transaction_params
    params.require(:purchase).permit(:code, :name, :valid_date, :cpf)
          .merge(value: 100, number: params[:purchase][:card_number])
  end
end
