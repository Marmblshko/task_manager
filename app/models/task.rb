class Task < ApplicationRecord
  belongs_to :project
  has_one :report, dependent: :destroy
  enum status: %i(Fresh Working Complited)

  accepts_nested_attributes_for :report
  validates :title, presence: true
  validates :description, presence: true
  validates :status, presence: true
end
