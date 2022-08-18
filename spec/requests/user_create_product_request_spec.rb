require 'rails_helper'

describe 'user create product' do
  it 'from url' do
    product = attributes_for :product

    post products_path, params: { product: }

    expect(response).to redirect_to new_admin_session_path
  end
end
