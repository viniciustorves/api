require 'rails_helper'

RSpec.describe 'Groups API' do
  let(:default_params) { { format: :json } }

  describe 'GET show' do
    it 'returns a group', :show_in_doc do
      group = create(:group)

      get group_path(group, format: :json)

      expect(response.body).to eq serialize(group)
    end
  end

  describe 'GET index' do
    it 'returns a list of groups' do
      groups = create_list(:group, 2)

      get groups_path(format: :json)

      expect(response.body).to eq serialize(groups)
    end
  end

  describe 'POST create' do
    it 'creates a group' do
      group_attributes = attributes_for(:group)

      post groups_path, group_attributes

      group = Group.last
      expect(response.body).to eq serialize(group)
    end
  end
end
