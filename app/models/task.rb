class Task < ApplicationRecord
  belongs_to :project
  has_one :report, dependent: :destroy
  enum status: %i(Fresh Working Complited)

  validates :title, presence: true
  validates :description, presence: true
  validates :status, presence: true
end
