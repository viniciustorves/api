require 'rails_helper'

feature 'Admin creates a role', :js do
  scenario 'fills in fields and successfully creates the role' do
    role = build(:role)
    # sign in as admin
    login_as(create(:staff, :admin))
    visit '/admin/roles/add'
    # fill in name description
    fill_in('Role Name', with: role.name)
    fill_in('Role Description', with: role.description)
    # set correct permissions
    %w(.permissions-projects .permissions-approvals .permissions-memberships).each do |container|
      within(container) do
        check 'Read'
        check 'Write'
      end
    end
    # submit
    # make sure role was created
  end
end
