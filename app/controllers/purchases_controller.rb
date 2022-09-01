class PurchasesController < ApplicationController
  def new
    @purchase = Purchase.new
  end

  def create
    purchase = Purchase.new(purchase_params)
    if purchase.save
      response = TransactionService.send(transaction_params, current_client.purchases.last.order)
      TransactionService.change_status(purchase, response)
      redirect_to feedback_purchase_path(purchase)
    else

    end
  end

  def feedback
    @purchase = Purchase.find(params[:id])
  end

  def purchase_params
    params.require(:purchase).permit(:client_id, :card_number)
          .merge(value: current_client.cart_total_value, product_items: current_client.product_items)
  end

  def transaction_params
    params.require(:purchase).permit(:code, :name, :valid_date, :cpf)
          .merge(value: current_client.cart_total_value.to_f, number: params[:purchase][:card_number])
  end
end
