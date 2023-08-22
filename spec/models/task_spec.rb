require 'rails_helper'

describe Task do
  describe "validations" do
    it {should validate_presence_of :title}
    it {should validate_presence_of :description}
    it {should validate_presence_of :status}
    it {should validate_presence_of :project_id}
  end

  describe "associations" do
    it {should belong_to :project}
    it {should have_one :report}
  end
end