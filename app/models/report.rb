class Report < ApplicationRecord
  belongs_to :task

  validates :title, presence: true
  validates :description, presence: true
end
