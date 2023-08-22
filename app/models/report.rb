class Report < ApplicationRecord
  belongs_to :task, inverse_of: :report

  validates :title, presence: true
  validates :description, presence: true
end
