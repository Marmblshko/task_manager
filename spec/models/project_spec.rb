require 'rails_helper'

describe Project do
  describe "validations" do
    it {should validate_presence_of :title}
    it {should validate_presence_of :description}
    it {should validate_presence_of :creator_id}
  end

  describe "database" do
    it { should have_db_column(:title).of_type(:string) }
    it { should have_db_column(:description).of_type(:text) }
    it { should have_db_column(:creator_id).of_type(:integer) }
    it { should have_db_column(:users_in_project).of_type(:integer).with_options(array: true, default: []) }
  end

  describe "associations" do
    it {should have_many(:tasks).dependent(:destroy)}
    it {should have_many(:users).through(:memberships) }
    it {should have_many :memberships}
  end

  describe '#title' do
    it 'return new project title' do
      project = create(:project, title: 'New title for test')
      expect(project.title).to eq 'New title for test'
    end
  end

  describe '#description' do
    it 'return new project description' do
      project = create(:project, description: 'Some new description for test')
      expect(project.description).to eq 'Some new description for test'
    end
  end

  describe '#creator_id' do
    it 'return new project creator_id' do
      project = create(:project, creator_id: 3)
      expect(project.creator_id).to eq 3
    end
  end
end
