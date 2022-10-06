class PurchasesController < ApplicationController
  before_action :verify_card, only: :create

  def new
    return redirect_to shopping_cart_path, notice: 'Ops' unless ProductService.stock?(current_client.product_items)

    @purchase = Purchase.new
    @card = Card.new
  end

  def create
    purchase = Purchase.create(purchase_params)
    response = TransactionService.send(card_params, current_client)
    if response&.status == 201
      json_response = JSON.parse(response.body)
      TransactionService.change_status(purchase, json_response)
      return redirect_to feedback_purchase_path(purchase) if json_response['status'] != 'rejected'
      return redirect_to new_purchase_path, notice: t('payment_rejected') if json_response['status'] == 'rejected'
    end
    redirect_to new_purchase_path, notice: response&.status != 404 ? t('payment_failed') : t('invalid_card')
    purchase.destroy
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

  def verify_card
    @card = Card.new(card_params)
    return render :new unless @card.valid?
  end
end
