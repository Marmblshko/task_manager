require 'rails_helper'

describe User do
  describe "validations" do
    it { should validate_presence_of :username }
    it { should validate_uniqueness_of :username }
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }

    it { should validate_confirmation_of(:password) }
    it { should allow_value('user@example.com').for(:email) }
    it { should_not allow_value('user').for(:email) }

    it { should define_enum_for(:role).with_values(User: 0, Moderator: 1, Admin: 2) }
    it { should allow_value(:User, :Moderator, :Admin).for(:role) }
  end

  describe "associations" do
    it { should have_many(:projects).through(:memberships).dependent(:destroy) }
    it { should have_many(:memberships).dependent(:destroy) }
  end

  describe "database" do
    it { should have_db_column(:email).of_type(:string).with_options(default: "", null: false) }
    it { should have_db_column(:encrypted_password).of_type(:string).with_options(default: "", null: false) }
    it { should have_db_column(:reset_password_token).of_type(:string) }
    it { should have_db_column(:reset_password_sent_at).of_type(:datetime) }
    it { should have_db_column(:remember_created_at).of_type(:datetime) }
    it { should have_db_column(:username).of_type(:string) }
    it { should have_db_column(:role).of_type(:integer).with_options(default: "User") }
  end
end
