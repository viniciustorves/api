class CreateGroupsMembershipsAndGroupProjects < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.timestamps
      t.string :name
      t.text :description
    end

    create_table :memberships do |t|
      t.timestamps
      t.references :group, index: true, foreign_key: true
      t.references :staff, index: true, foreign_key: true
    end

    create_table :groups_projects do |t|
      t.timestamps
      t.references :group, index: true, foreign_key: true
      t.references :project, index: true, foreign_key: true
    end
  end
end
