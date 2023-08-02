class Task < ApplicationRecord
  belongs_to :project

  enum status: %i(Fresh Working Complited)

  validates :title, presence: true
  validates :description, presence: true
  validates :status, presence: true
end
