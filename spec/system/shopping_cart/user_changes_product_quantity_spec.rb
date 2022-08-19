require 'rails_helper'

describe 'cliente changes product quantity' do
  it 'increment' do
    client = create :client
    product = create :product
    2.times { create :stock_product, product: }
    item = create :product_item, product:, client:, quantity: 1

    login_as client, scope: :client
    visit shopping_cart_path
    click_on '+'

    item.reload
    expect(page).to have_content product.name
    expect(page.find('.item_quantity')).to have_content '2'
  end

  it 'increment when there is no more product in stock' do
    client = create :client
    product = create :product
    create :stock_product, product: product
    item = create :product_item, product:, client:, quantity: 1

    login_as client, scope: :client
    visit shopping_cart_path
    click_on '+'

    item.reload
    expect(page).to have_content 'Não há mais produtos em estoque'
    expect(page.find('.item_quantity')).to have_content '1'
    expect(item.quantity).to eq 1
  end

  it 'decrement' do
    client = create :client
    product = create :product
    2.times { create :stock_product, product: }
    item = create :product_item, product:, client:, quantity: 2

    login_as client, scope: :client
    visit shopping_cart_path
    click_on '-'

    item.reload
    expect(page).to have_content product.name
    expect(page.find('.item_quantity')).to have_content '1'
  end

  it 'decrement when quantity is one' do
    client = create :client
    product = create :product
    2.times { create :stock_product, product: }
    create :product_item, product:, client:, quantity: 1

    login_as client, scope: :client
    visit shopping_cart_path
    click_on '-'

    expect(page).not_to have_content product.name
    expect(page).to have_content 'Não há produtos no carrinho'
  end
end
