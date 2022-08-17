require 'rails_helper'

describe 'visitor tries add product to shopping_cart' do
  it 'and returns to login screen' do
    product = create :product, name: 'Memoria RAM 8GB', brand: 'Kingspec', price: 170
    2.times { create :stock_product, product: }

    visit root_path
    click_on 'Memoria RAM 8GB'
    click_on 'Adicionar ao carrinho'

    expect(page).to have_current_path new_client_session_path
    expect(ProductItem.count).to eq 0
  end
end

describe 'client add product to shopping_cart' do
  it 'success' do
    client = create :client
    product = create :product, name: 'Memoria RAM 8GB', brand: 'Kingspec', price: 170
    2.times { create :stock_product, product: }

    login_as client, scope: :client
    visit root_path
    click_on 'Memoria RAM 8GB'
    click_on 'Adicionar ao carrinho'

    expect(page).to have_current_path shopping_cart_path
    expect(page).to have_content 'Produto adicionado ao carrinho'
    expect(page).to have_content 'Memoria RAM 8GB'
    expect(page).to have_content 'Preço: R$ 170,00'
    expect(page.find('.item_quantity')).to have_content '1'
  end

  it 'and not duplicate items' do
    client = create :client
    product = create :product, name: 'Memoria RAM 8GB', brand: 'Kingspec', price: 170
    2.times { create :stock_product, product: }

    login_as client, scope: :client
    visit root_path
    click_on 'Memoria RAM 8GB'
    click_on 'Adicionar ao carrinho'
    visit product_path(product)
    click_on 'Adicionar ao carrinho'

    expect(page).to have_content 'Memoria RAM 8GB'
    expect(page).to have_content 'Preço: R$ 170,00'
    expect(page.find('.item_quantity')).to have_content '2'
  end

  it 'and does not add if stock is 0' do
    client = create :client
    create :product, name: 'Memoria RAM 8GB', brand: 'Kingspec', price: 170

    login_as client, scope: :client
    visit root_path
    click_on 'Memoria RAM 8GB'

    expect(page).to have_content 'Produto não disponivel'
    expect(page).not_to have_button 'Adiconar ao carrinho'
  end
end
