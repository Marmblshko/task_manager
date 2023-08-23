class ChangeTaskStatusToInteger < ActiveRecord::Migration[7.0]
  def change
    change_column :tasks, :status, :integer, using: 'status::integer', default: 0
  end
end
