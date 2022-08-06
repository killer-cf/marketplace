require 'rails_helper'

describe 'admin sees products' do
  it 'from initial screen' do
    product1 = create :product
    product2 = create :product

    visit root_path

    expect(page).to have_content product1.name
    expect(page).to have_content product1.brand
    expect(page).to have_content product1.price
    expect(page).to have_content product2.name
    expect(page).to have_content product2.brand
    expect(page).to have_content product2.price
  end
end
