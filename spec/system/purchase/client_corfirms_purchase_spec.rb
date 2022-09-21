require 'rails_helper'

describe 'client confirm purchase' do
  it 'success' do
    client = create :client
    product1 = create :product, price: 100
    product2 = create :product, price: 200
    item = create :product_item, product: product1, client:, quantity: 1
    item2 = create :product_item, product: product2, client:, quantity: 2
    purchase_data_sent = { transaction: { code: '123', name: 'KILDER COSTA M FILHO', valid_date: '11/20/2030',
                                          cpf: '12345678901', number: '1234567890123456',
                                          order: 'ASDF123456', value: 500.0 } }.to_json
    purchase_response_body = { status: 'accepted', message: nil }.to_json
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
    expect(current_path).to eq feedback_purchase_path(Purchase.last)
    expect(page).to have_content 'Pedido ASDF123456 realizado com sucesso'
    expect(page).to have_content 'Sua compra foi aprovada!'
    expect(page).to have_content 'Pago com cartão final 3456'
    expect(page).to have_content 'Total do pedido: R$ 500,00'
    expect(page).to have_content "1x #{item.product.name}"
    expect(page).to have_content "2x #{item2.product.name}"
  end

  it 'when card theres no exists' do
    client = create :client
    product1 = create :product, price: 100
    product2 = create :product, price: 200
    create :product_item, product: product1, client:, quantity: 1
    create :product_item, product: product2, client:, quantity: 2
    purchase_data_sent = { transaction: { code: '123', name: 'KILDER COSTA M FILHO', valid_date: '11/20/2030',
                                          cpf: '12345678901', number: '1234567890123456',
                                          order: 'ASDF123456', value: 500.0 } }.to_json
    purchase_response_body = { errors: 'Cartão invalido, revise os dados' }.to_json
    purchase_response = instance_double Faraday::Response, status: 404, body: purchase_response_body
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

    expect(Purchase.count).to eq 0
    expect(page).to have_current_path new_purchase_path
    expect(page).not_to have_content 'Falha ao fazer pagamento, tente novamente mais tarde!'
    expect(page).to have_content 'Cartão invalido, revise os dados'
  end

  it 'when theres no limit on card' do
    client = create :client
    product1 = create :product, price: 100
    product2 = create :product, price: 200
    item = create :product_item, product: product1, client:, quantity: 1
    item2 = create :product_item, product: product2, client:, quantity: 2
    purchase_data_sent = { transaction: { code: '123', name: 'KILDER COSTA M FILHO', valid_date: '11/20/2030',
                                          cpf: '12345678901', number: '1234567890123456',
                                          order: 'ASDF123456', value: 500.0 } }.to_json
    purchase_response_body = { status: 'rejected', message: nil }.to_json
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

    expect(page).to have_content 'Compra rejeitada pelo banco, entre em contato com o banco ou informe outro meio de pagamento'
    expect(Purchase.count).to eq 0
  end

  it 'with invalid fields' do
    client = create :client
    product1 = create :product, price: 100
    product2 = create :product, price: 200
    create :product_item, product: product1, client:, quantity: 1
    create :product_item, product: product2, client:, quantity: 2

    login_as client, scope: :client
    visit shopping_cart_path
    click_on 'Ir para pagamento'
    fill_in 'Nome no cartão', with: 'KILDER COSTA M FILHO'
    fill_in 'Numero', with: '1234'
    fill_in 'Código', with: '12'
    fill_in 'Data de validade', with: '11/20/2030'
    fill_in 'CPF', with: '123456'
    click_on 'Fazer pagamento'

    expect(page).not_to have_content 'Sua compra foi aprovada!'
    expect(Purchase.count).to eq 0
    expect(page).to have_content 'Numero não possui o tamanho esperado (16 caracteres)'
    expect(page).to have_content 'Código não possui o tamanho esperado (3 caracteres)'
    expect(page).to have_content 'CPF não possui o tamanho esperado (11 caracteres)'
  end

  it 'with blank fields' do
    client = create :client
    product1 = create :product, price: 100
    product2 = create :product, price: 200
    create :product_item, product: product1, client:, quantity: 1
    create :product_item, product: product2, client:, quantity: 2

    login_as client, scope: :client
    visit shopping_cart_path
    click_on 'Ir para pagamento'
    click_on 'Fazer pagamento'

    expect(page).not_to have_content 'Sua compra foi aprovada!'
    expect(Purchase.count).to eq 0
    expect(page).to have_content 'Numero não pode ficar em branco'
    expect(page).to have_content 'Código não pode ficar em branco'
    expect(page).to have_content 'CPF não pode ficar em branco'
    expect(page).to have_content 'Nome no cartão não pode ficar em branco'
  end

  it 'and API is offline' do
    client = create :client
    product1 = create :product, price: 100
    product2 = create :product, price: 200
    create :product_item, product: product1, client:, quantity: 1
    create :product_item, product: product2, client:, quantity: 2
    allow(Faraday).to receive(:post).and_raise(Faraday::ConnectionFailed)

    login_as client, scope: :client
    visit shopping_cart_path
    click_on 'Ir para pagamento'
    fill_in 'Nome no cartão', with: 'KILDER COSTA M FILHO'
    fill_in 'Numero', with: '1234567890123456'
    fill_in 'Código', with: '123'
    fill_in 'Data de validade', with: '11/20/2030'
    fill_in 'CPF', with: '12345678901'
    click_on 'Fazer pagamento'

    expect(Purchase.count).to eq 0
    expect(page).to have_current_path new_purchase_path
    expect(page).to have_content 'Falha ao fazer pagamento, tente novamente mais tarde!'
  end
end
