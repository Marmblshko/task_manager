require 'rails_helper'

describe User do
  describe "validations" do
    it {should validate_presence_of :username}
    it {should validate_uniqueness_of :username}
    it {should validate_presence_of :email}
    it {should validate_presence_of :password}
  end

  describe "associations" do
    it {should have_many :projects}
    it {should have_many :memberships}
  end
end