require 'rails_helper'

describe 'user add product to cart' do
  it 'but theres not product in stock' do
    client = create :client
    product = create :product, name: 'Memoria RAM 8GB', brand: 'Kingspec', price: 170
    login_as client, scope: :client

    post product_product_items_path(product)

    expect(response).to redirect_to product_path(product)
  end
end
