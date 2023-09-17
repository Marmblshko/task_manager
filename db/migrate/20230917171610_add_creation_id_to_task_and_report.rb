class AddCreationIdToTaskAndReport < ActiveRecord::Migration[7.0]
  def change
    add_column :reports, :creator_id, :integer
    add_column :tasks, :creator_id, :integer
  end
end
