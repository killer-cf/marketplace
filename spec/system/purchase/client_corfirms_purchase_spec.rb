require 'rails_helper'

describe 'client confirm purchase' do
  it 'success' do
    client = create :client
    product1 = create :product
    product2 = create :product
    item = create :product_item, product: product1, client:, quantity: 1
    item2 = create :product_item, product: product2, client:, quantity: 2
    purchase_data_sent = { transaction: { code: '123', name: 'KILDER COSTA M FILHO', valid_date: '11/20/2030',
                                          cpf: '12345678901', value: 100, number: '1234567890123456',
                                          order: 'ASDF123456' } }.to_json
    purchase_response_body = { status: 'accepted', message: nil }
    purchase_response = instance_double Faraday::Response, status: 201, body: purchase_response_body
    allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/transactions', purchase_data_sent,
                                          content_type: 'application/json').and_return(purchase_response)
    allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('ASDF123456')

    login_as client, scope: :client
    visit shopping_cart_path
    click_on 'Ir para pagamento'
    fill_in 'Nome no cartão', with: 'KILDER COSTA M FILHO'
    fill_in 'Numero', with: '1234567890123456'
    fill_in 'Código', with: '123'
    fill_in 'Data de validade', with: '11/20/2030'
    fill_in 'CPF', with: '12345678901'
    click_on 'Fazer pagamento'

    expect(Purchase.count).to eq 1
    expect(Purchase.last).to be_approved
    expect(current_path).to eq purchase_path(Purchase.last)
    expect(page).to have_content 'Pedido ASDF123456 realizado com sucesso'
    expect(page).to have_content 'Sua compra foi aprovada!'
    expect(page).to have_content 'Pago com cartão final 9876'
    expect(page).to have_content 'Total do pedido: R$ 850,00'
    expect(page).to have_content "1x #{item.product.name}"
    expect(page).to have_content "2x #{item2.product.name}"
  end
end
