class PurchasesController < ApplicationController
  def new
    @purchase = Purchase.new
    @card = Card.new
  end

  def create
    @card = Card.new(card_params)
    return render :new unless @card.valid?
    return unless purchase.save

    purchase = Purchase.new(purchase_params)
    response = TransactionService.send(card_params, current_client)
    return if response.status != 201

    TransactionService.change_status(purchase, response)
    redirect_to feedback_purchase_path(purchase)
  end

  def feedback
    @purchase = Purchase.find(params[:id])
  end

  def purchase_params
    params.require(:purchase).permit(:client_id)
          .merge(value: current_client.cart_total_value, product_items: current_client.product_items,
                 card_number: params[:card][:number])
  end

  def card_params
    params.require(:card).permit(:code, :name, :valid_date, :cpf, :number)
          .merge(client_id: params[:purchase][:client_id])
  end
end
