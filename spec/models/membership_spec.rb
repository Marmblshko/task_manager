require 'rails_helper'

RSpec.describe Membership, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:project) }
  end

  describe "database" do
    it { should have_db_column(:user_id).of_type(:integer) }
    it { should have_db_column(:project_id).of_type(:integer) }
    it { should have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { should have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
  end
end