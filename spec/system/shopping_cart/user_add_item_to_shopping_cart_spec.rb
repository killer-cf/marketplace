require 'rails_helper'

describe 'visitor tries add product to shopping_cart' do
  it 'and returns to login screen' do
    create :product, name: 'Memoria RAM 8GB', brand: 'Kingspec', price: 170

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
    create :product, name: 'Memoria RAM 8GB', brand: 'Kingspec', price: 170

    login_as client, scope: :client
    visit root_path
    click_on 'Memoria RAM 8GB'
    click_on 'Adicionar ao carrinho'

    expect(page).to have_current_path shopping_cart_path
    expect(page).to have_content 'Produto adicionado ao carrinho'
    expect(page).to have_content 'Memoria RAM 8GB'
    expect(page).to have_content 'Preço: R$ 170,00'
  end
end
