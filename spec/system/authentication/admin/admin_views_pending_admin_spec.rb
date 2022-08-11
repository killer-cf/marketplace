require 'rails_helper'

describe 'admin sees pendings admins' do
  it 'from initial screen' do
    admin = create :admin
    create :admin, email: 'jose@hotmail.com.br', name: 'José', status: :pending
    create :admin, email: 'maria@hotmail.com.br', name: 'Maria', status: :pending
    create :admin, email: 'fernando@hotmail.com.br', name: 'Fernando', status: :approved
    create :admin, email: 'bruno@hotmail.com.br', name: 'Bruno', status: :rejected

    login_as admin, scope: :admin
    visit root_path
    click_on 'Admins pendentes'

    expect(page).to have_content 'Cadastros de Administradores pendentes'
    expect(page).to have_content "Nome\nJosé"
    expect(page).to have_content "E-mail\njose@hotmail.com.br"
    expect(page).to have_content "Nome\nMaria"
    expect(page).to have_content "E-mail\nmaria@hotmail.com.br"
    expect(page).not_to have_content "Nome\nFernando"
    expect(page).not_to have_content "E-mail\nfernando@hotmail.com.br"
    expect(page).not_to have_content "Nome\nBruno"
    expect(page).not_to have_content "E-mail\nbruno@hotmail.com.br"
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

  it 'and reject success' do
    admin = create :admin
    pending_admin = create :admin, :pending

    login_as admin, scope: :admin
    visit root_path
    click_on 'Admins pendentes'
    click_on 'Rejeitar'

    pending_admin.reload
    expect(page).to have_content 'Não existem admin pendentes de aprovação'
    expect(pending_admin.rejected?).to eq true
  end
end
