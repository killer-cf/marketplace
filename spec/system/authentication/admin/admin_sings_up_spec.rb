require 'rails_helper'

describe 'admin sings up' do
  it 'success' do
    visit root_path
    click_on 'Registrar novo admin'

    fill_in 'Nome', with: 'Kilder'
    fill_in 'E-mail', with: 'kilder@example.com'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirmar senha', with: 'password'
    click_on 'Registrar'

    expect(page).to have_current_path root_path
    expect(page).to have_content 'Cadastro efetuado com sucesso. Esperando por aprovação por outro Administrador.'
    expect(page).to have_link 'Entrar'
    expect(page).not_to have_content('Kilder | kilder@example.com')
  end
end
