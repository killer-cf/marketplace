require 'rails_helper'

describe 'admin sings in' do
  it 'success' do
    create :admin, name: 'Kilder', email: 'kilder@example.com', approved: true

    visit root_path
    click_on 'Entrar'
    fill_in 'E-mail', with: 'kilder@example.com'
    fill_in 'Senha', with: 'password'
    find('.actions').click_on 'Entrar'

    expect(page).to have_current_path root_path
    expect(page).to have_content('Kilder | kilder@example.com')
    expect(page).not_to have_link('Entrar')
    expect(page).to have_content('Autenticação efetuada com sucesso.')
  end

  it 'with blank fields' do
    create :admin, name: 'Kilder', email: 'kilder@example.com', approved: true

    visit root_path
    click_on 'Entrar'
    fill_in 'E-mail', with: ''
    fill_in 'Senha', with: ''
    find('.actions').click_on 'Entrar'

    expect(page).to have_content 'E-mail ou senha inválidos.'
    expect(page).not_to have_content 'Autenticação efetuada com sucesso.'
  end

  it 'with incorrect fields' do
    create :admin, name: 'Kilder', email: 'kilder@example.com', approved: true

    visit new_admin_session_path
    fill_in 'E-mail', with: 'kilderexample.com'
    fill_in 'Senha', with: '123'
    find('.actions').click_on 'Entrar'

    expect(page).not_to have_content 'Autenticação efetuada com sucesso.'
    expect(page).to have_content 'E-mail ou senha inválidos.'
  end
end
