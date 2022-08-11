require 'rails_helper'

describe 'Admin sings out of the system' do
  it 'success' do
    admin = create :admin, name: 'kilder', email: 'kilder@example.com'

    login_as admin, scope: :admin
    visit root_path
    click_on 'Sair'

    expect(page).to have_current_path root_path
    expect(page).to have_content 'Saída efetuada com sucesso.'
    expect(page).to have_link 'Entrar'
    expect(page).not_to have_link 'Sair'
    expect(page).not_to have_content 'kilder | kilder@example.com'
  end
end
