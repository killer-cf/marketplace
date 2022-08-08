require 'rails_helper'

describe 'admin create product' do
  it 'success' do
    visit root_path
    click_on 'Cadastrar produto'
    fill_in 'Nome', with: 'Franela da Apple'
    fill_in 'Marca', with: 'Apple'
    fill_in 'Descrição', with: 'A franela mais cara pra fazer oque as outras tambem fazem'
    fill_in 'Preço', with: '300'
    fill_in 'Largura', with: '30'
    fill_in 'Altura', with: '60'
    fill_in 'Profundidade', with: '1'
    fill_in 'Peso', with: '0.2'
    click_on 'Cadastrar'
    expect(page).to have_content('Produto criado com sucesso')
    expect(current_path).to eq product_path(Product.last.id)
    expect(page).to have_content('Franela da Apple')
    expect(page).to have_content('R$ 300,00')
    expect(page).to have_content('Apple')
    expect(page).to have_content('A franela mais cara pra fazer oque as outras tambem fazem')
    expect(page).to have_content('Dimenções: 30.0 x 60.0 x 1.0')
    expect(page).to have_content('Peso: 0.2')
  end
end
