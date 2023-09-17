class AddUsersToProjects < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :users_in_project, :integer, array:true, default: []
  end
end
