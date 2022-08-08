require 'rails_helper'

describe 'admin changes products status' do
  it 'to inactive' do
    product = create :product, status: :inactive

    visit root_path
    click_on product.name
    click_on 'Ativar'

    expect(page).to have_content 'Status: Ativo'
  end
end
