# == Schema Information
#
# Table name: memberships
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  group_id   :integer
#  staff_id   :integer
#
# Indexes
#
#  index_memberships_on_group_id  (group_id)
#  index_memberships_on_staff_id  (staff_id)
#

class Membership < ActiveRecord::Base
  belongs_to :group
  belongs_to :staff
end
