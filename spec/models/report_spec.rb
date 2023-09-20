require 'rails_helper'

describe Report do
  describe "validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :description }
  end

  describe "associations" do
    it { should belong_to :task }
  end

  describe "database" do
    it { should have_db_column(:title).of_type(:string) }
    it { should have_db_column(:description).of_type(:text) }
    it { should have_db_column(:task_id).of_type(:integer).with_options(null: false) }
    it { should have_db_column(:creator_username).of_type(:string) }
    it { should have_db_column(:creator_id).of_type(:integer) }
  end
end