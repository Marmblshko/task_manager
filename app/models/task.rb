class Task < ApplicationRecord
  belongs_to :project
  has_many :reports, dependent: :destroy
  enum status: {
    Fresh: 0,
    Working: 1,
    Completed: 2
  }, _default: :Fresh

  accepts_nested_attributes_for :reports, reject_if: proc { |attributes| attributes.blank? }, update_only: true
  validates :title, presence: true
  validates :description, presence: true
  validates :status, presence: true

  broadcasts_to ->(task) { :tasks_list }, inserts_by: :prepend
end
