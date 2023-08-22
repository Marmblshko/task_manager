require 'rails_helper'

describe Project do
  describe "validations" do
    it {should validate_presence_of :title}
    it {should validate_presence_of :description}
    it {should validate_presence_of :creator_id}
  end

  describe "associations" do
    it {should have_many :tasks}
    it {should have_many :users}
    it {should have_many :memberships}
  end

  describe "#title" do
    it "return new project title" do
      project = create(:project, title: 'New title for test')
      expect(project.title).to eq 'New title for test'
    end
  end

  describe "#description" do
    it "return new project description" do
      project = create(:project, description: 'Some new description for test')
      expect(project.description).to eq 'Some new description for test'
    end
  end

  describe "#creator_id" do
    it "return new project creator_id" do
      project = create(:project, creator_id: 3)
      expect(project.creator_id).to eq 3
    end
  end
end