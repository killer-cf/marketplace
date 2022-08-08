require 'rails_helper'

describe 'visitor sees product details' do
  it 'from initial screen' do
    product = create :product, price: 400.0

    visit root_path
    click_on product.name

    expect(page).to have_content product.name
    expect(page).to have_content product.sku
    expect(page).to have_content "Marca: #{product.brand}"
    expect(page).to have_content product.description
    expect(page).to have_content "Dimenções: #{product.width} x #{product.height} x #{product.depth}"
    expect(page).to have_content "Peso: #{product.weight}"
    expect(page).to have_content 'R$ 400,00'
    expect(page).not_to have_content "Status: #{product.status}"
  end

  it 'and product no exists' do
    visit product_path(99)

    expect(page).to have_current_path root_path
    expect(page).to have_content 'Produto inativo ou inexistente'
  end
end
