require 'rails_helper'

feature 'Add group to project', js: true do
  scenario 'give group access to a project by adding it on the project edit page' do
    group = create(:group)
    project = create(:project)
    login_as create(:user)

    visit "/project/#{project.id}"
    fill_in '#groups_search', with: group.name
    #click enter
    expect(find('.groups-list')).to have_content(group.name)

    expect(project.groups).to include(group)
  end
end
