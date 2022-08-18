require 'rails_helper'

describe 'client see products' do
  it 'from initial screen' do
    product = create :product, name: 'SSD', price: 460
    product2 = create :product, name: 'Memoria RAM', price: 170
    create(:stock_product, product:)
    client = create :client
    create(:product_item, product:, client:)
    create(:product_item, product: product2, client:, quantity: 2)

    login_as client, scope: :client
    visit root_path
    click_on 'Carrinho'

    within('#SSD') do
      expect(page).to have_content 'SSD'
      expect(page).to have_content 'Valor unitario: R$ 460,00'
      expect(page).to have_content 'Subtotal: R$ 460,00'
      expect(page).to have_content '1'
    end
    within('#Memoria-RAM') do
      expect(page).to have_content 'Memoria RAM'
      expect(page).to have_content 'Valor unitario: R$ 170,00'
      expect(page).to have_content 'Subtotal: R$ 340,00'
      expect(page).to have_content '2'
    end
    expect(page).to have_content 'Valor Total: R$ 800,00'
  end

  it 'and there are not products in cart' do
    product = create :product, name: 'SSD', price: 460
    create(:stock_product, product:)
    client = create :client

    login_as client, scope: :client
    visit root_path
    click_on 'Carrinho'

    expect(page).to have_content 'Não há produtos no carrinho'
  end
end
