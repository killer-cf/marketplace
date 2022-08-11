require 'rails_helper'

describe 'admin sees pendings admins' do
  it 'from initial screen' do
    admin = create :admin
    create :admin, email: 'jose@mercadores.com.br', name: 'José', status: :pending
    create :admin, email: 'maria@mercadores.com.br', name: 'Maria', status: :pending
    create :admin, email: 'fernando@mercadores.com.br', name: 'Fernando', status: :approved

    login_as admin, scope: :admin
    visit root_path
    click_on 'Admins pendentes'

    expect(page).to have_content 'Cadastros de Administradores pendentes'
    expect(page).to have_content "Nome\nJosé"
    expect(page).to have_content "E-mail\njose@mercadores.com.br"
    expect(page).to have_content "Nome\nMaria"
    expect(page).to have_content "E-mail\nmaria@mercadores.com.br"
    expect(page).not_to have_content "Nome\nFernando"
    expect(page).not_to have_content "E-mail\nfernando@mercadores.com.br"
  end

  it 'and approve success' do
    admin = create :admin
    pending_admin = create :admin, :pending

    login_as admin, scope: :admin
    visit root_path
    click_on 'Admins pendentes'
    click_on 'Aprovar'

    pending_admin.reload
    expect(page).to have_content 'Não existem admin pendentes de aprovação'
    expect(pending_admin.approved?).to eq true
  end
end
