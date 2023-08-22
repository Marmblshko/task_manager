class Task < ApplicationRecord
  belongs_to :project
  has_one :report, foreign_key: :task_id, dependent: :destroy, inverse_of: :task
  enum status: {
    Fresh: 0,
    Working: 1,
    Completed: 2
  }, _default: :Fresh

  accepts_nested_attributes_for :report, reject_if: proc { |attributes| attributes['title'].blank? }, update_only: true
  validates :title, presence: true
  validates :description, presence: true
  validates :status, presence: true
  validates :project_id, presence: true
end
