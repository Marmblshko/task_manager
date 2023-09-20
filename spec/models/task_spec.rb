require 'rails_helper'

describe Task do
  describe "validations" do
    it {should validate_presence_of :title}
    it {should validate_presence_of :description}
    it {should validate_presence_of :status}
    it {should validate_presence_of :project_id}
    it { should define_enum_for(:status).with_values(Fresh: 0, Working: 1, Completed: 2) }
    it { should allow_value(:Fresh, :Working, :Completed).for(:status) }
    it { should accept_nested_attributes_for(:reports).update_only(true) }
  end

  describe "associations" do
    it {should belong_to :project}
    it { should have_many(:reports).dependent(:destroy) }
  end

  describe "database" do
    it { should have_db_column(:title).of_type(:string) }
    it { should have_db_column(:description).of_type(:text) }
    it { should have_db_column(:status).of_type(:integer).with_options(default: "Fresh") }
    it { should have_db_column(:project_id).of_type(:integer).with_options(null: false) }
    it { should have_db_column(:creator_id).of_type(:integer) }
  end
end