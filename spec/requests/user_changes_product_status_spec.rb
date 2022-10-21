require 'rails_helper'

describe 'user changes product status' do
  it 'from url to deactivate' do
    product = create :product

    post deactivate_product_path(product.id)

    expect(response).to redirect_to new_admin_session_path
  end

  it 'from url to activate' do
    product = create :product

    post activate_product_path(product.id)

    expect(response).to redirect_to new_admin_session_path
  end
end
