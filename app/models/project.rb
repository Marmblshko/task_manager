class Project < ApplicationRecord
  has_many :tasks, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  validates :title, presence: true
  validates :description, presence: true
  validates :creator_id, presence: true
end
