class AddCreationNameToReport < ActiveRecord::Migration[7.0]
  def change
    add_column :reports, :creator_username, :string
  end
end
