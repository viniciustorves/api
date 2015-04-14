class CreateGroupsMembershipsAndGroupProjects < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.timestamps
      t.string :name
      t.text :description
    end

    create_table :memberships do |t|
      t.timestamps
      t.references :group, index: true
      t.references :staff, index: true
    end
    add_foreign_key :memberships, :groups, on_delete: :cascade
    add_foreign_key :memberships, :staff, on_delete: :cascade

    create_table :groups_projects do |t|
      t.timestamps
      t.references :group, index: true
      t.references :project, index: true
    end
    add_foreign_key :groups_projects, :groups, on_delete: :cascade
    add_foreign_key :groups_projects, :projects, on_delete: :cascade
  end
end
