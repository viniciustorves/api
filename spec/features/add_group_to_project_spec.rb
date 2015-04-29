require 'rails_helper'

feature 'Add group to project', js: true do
  scenario 'give group access to a project by adding it on the project edit page' do
    group = create(:group)
    project = create(:project)
    login_as create(:staff, :admin)

    visit "/project/#{project.id}"
    find('#group_search input.ui-select-search').click
    binding.pry
    find('span', text: group.name).click

    expect(find('.groups-list')).to have_content(group.name)
    expect(find('.groups-list')).to have_selector("group-#{group.id}")

    expect(project.groups).to include(group)
  end
end
