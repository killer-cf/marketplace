require 'rails_helper'

describe 'admin changes products status' do
  it 'to active' do
    product = create :product, status: :inactive
    admin = create :admin

    login_as admin, scope: :admin
    visit root_path
    click_on product.name
    click_on 'Ativar'

    expect(page).to have_current_path product_path(product)
    expect(page).to have_content 'Produto ativado com sucesso'
    expect(page).to have_content 'Status: Ativo'
    expect(page).to have_button 'Desativar'
    expect(page).not_to have_button 'Ativar'
  end

  it 'to inactive' do
    product = create :product, status: :active
    admin = create :admin

    login_as admin, scope: :admin
    visit root_path
    click_on product.name
    click_on 'Desativar'

    expect(page).to have_current_path product_path(product)
    expect(page).to have_content 'Produto desativado com sucesso'
    expect(page).to have_content 'Status: Inativo'
    expect(page).to have_button 'Ativar'
    expect(page).not_to have_button 'Desativar'
  end
end
