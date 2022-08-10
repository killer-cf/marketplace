require 'rails_helper'

describe 'admin create product' do
  it 'success' do
    visit root_path
    click_on 'Cadastrar produto'
    fill_in 'Nome', with: 'Iphone 13'
    fill_in 'Marca', with: 'Apple'
    fill_in 'Descrição', with: 'A franela mais cara pra fazer oque as outras tambem fazem'
    fill_in 'Preço', with: '10000'
    fill_in 'SKU', with: 'PLD3000346'
    fill_in 'Largura', with: '30'
    fill_in 'Altura', with: '60'
    fill_in 'Profundidade', with: '1'
    fill_in 'Peso', with: '0.2'
    attach_file 'Fotos', [Rails.root.join('spec/support/files/iphone-13-1.jpg'),
                          Rails.root.join('spec/support/files/iphone-13-2.jpg')]
    click_on 'Cadastrar'

    expect(page).to have_content('Produto criado com sucesso')
    expect(current_path).to eq product_path(Product.last.id)
    expect(page).to have_content('Iphone 13')
    expect(page).to have_content('R$ 10.000,00')
    expect(page).to have_content('Apple')
    expect(page).to have_content('A franela mais cara pra fazer oque as outras tambem fazem')
    expect(page).to have_content('Dimenções: 30.0 x 60.0 x 1.0')
    expect(page).to have_content('Peso: 0.2')
    expect(Product.last.photos.count).to eq 2
  end

  it 'with blank fields' do
    visit new_product_path
    click_on 'Cadastrar'

    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Marca não pode ficar em branco')
    expect(page).to have_content('Preço não pode ficar em branco')
    expect(page).to have_content('Largura não pode ficar em branco')
    expect(page).to have_content('Altura não pode ficar em branco')
    expect(page).to have_content('Descrição não pode ficar em branco')
    expect(page).to have_content('Profundidade não pode ficar em branco')
    expect(page).to have_content('Peso não pode ficar em branco')
    expect(page).to have_content('SKU não pode ficar em branco')
  end
end
