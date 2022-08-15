require 'rails_helper'

describe 'Admin changes stock product' do
  it 'only admins' do
    visit stock_products_path

    expect(page).to have_current_path new_admin_session_path
    expect(page).not_to have_content 'Controle de estoque'
  end

  it 'increasing stock' do
    admin = create :admin
    product = create :product

    login_as admin, scope: :admin
    visit visit root_path
    click_on 'Controle de estoque'
    fill_in 'query', with: '10'
    click_on 'Adicionar ao estoque'

    product.reload
    expect(page).to have_current_path stock_products_path
    expect(page).to have_content '10 unidades'
    expect(product.stock_products.count).to eq 10
  end

  it 'incorrect field' do
    admin = create :admin
    create :product

    login_as admin, scope: :admin
    visit visit root_path
    click_on 'Controle de estoque'
    fill_in 'query', with: 'soja'
    click_on 'Adicionar ao estoque'

    expect(page).to have_content '0 unidades'
  end

  it 'negative value' do
    admin = create :admin
    product = create :product
    5.times { create :stock_product, product: }

    login_as admin, scope: :admin
    visit visit root_path
    click_on 'Controle de estoque'
    fill_in 'query', with: '-2'
    click_on 'Adicionar ao estoque'

    expect(page).to have_content '5 unidades'
  end
end
