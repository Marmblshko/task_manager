class Task < ApplicationRecord
  belongs_to :project
  has_one :report, dependent: :destroy
  enum status: {
    Fresh: 0,
    Working: 1,
    Completed: 2
  }, _default: :Fresh

  accepts_nested_attributes_for :report, reject_if: proc { |attributes| attributes['title'].blank? }
  validates :title, presence: true
  validates :description, presence: true
  validates :status, presence: true
  validates :project_id, presence: true
end
