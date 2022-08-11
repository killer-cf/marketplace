require 'rails_helper'

describe 'visitor sees all products' do
  it 'from initial screen' do
    product1 = create :product, price: 200
    product2 = create :product, price: 300

    visit root_path

    expect(page).to have_content product1.name
    expect(page).to have_content product1.brand
    expect(page).to have_content 'R$ 200,00'
    expect(page).to have_content product2.name
    expect(page).to have_content product2.brand
    expect(page).to have_content 'R$ 300,00'
  end

  it 'and theres no products' do
    visit root_path

    expect(page).to have_content 'Não existem produtos'
  end

  it 'and not sees inactives products ' do
    product1 = create :product, price: 200, status: :inactive
    product2 = create :product, price: 300

    visit root_path

    expect(page).not_to have_content product1.name
    expect(page).not_to have_content product1.brand
    expect(page).not_to have_content 'R$ 200,00'
    expect(page).to have_content product2.name
    expect(page).to have_content product2.brand
    expect(page).to have_content 'R$ 300,00'
  end
end

describe 'admin sees all products inactives and actives' do
  it 'from initial screen' do
    product1 = create :product, price: 200, status: :inactive
    product2 = create :product, price: 300
    admin = create :admin

    login_as admin, scope: :admin
    visit root_path

    expect(page).to have_content product1.name
    expect(page).to have_content product1.brand
    expect(page).to have_content 'R$ 200,00'
    expect(page).to have_content product2.name
    expect(page).to have_content product2.brand
    expect(page).to have_content 'R$ 300,00'
  end
end
