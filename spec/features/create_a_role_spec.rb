require 'rails_helper'

feature 'Role creation' do
  scenario 'admin creates a role', :js do
    staff = create(:staff, :admin)
    login_as(staff)

    visit '/admin/roles/add'

    fill_in 'Name', with: 'Jellyfish Role #1'
    fill_in 'Description', with: 'This is a project manager role'
    within('#projects_permissions') { choose['read'] }
    within('#approval_permissions') { choose['read'] }
    within('#membership_permissions') { choose['read'] }

    click_on 'CREATE NEW ROLE'

    expect(page).to have_content('Role was successfully added.')
  end
end
