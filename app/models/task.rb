class Task < ApplicationRecord
  belongs_to :project
  has_one :report, dependent: :destroy
  enum status: {
    fresh: 0,
    working: 1,
    completed: 2
  }, _default: :fresh

  accepts_nested_attributes_for :report, reject_if: proc { |attributes| attributes['title'].blank? }
  validates :title, presence: true
  validates :description, presence: true
  validates :status, presence: true
  validates :project_id, presence: true
end
