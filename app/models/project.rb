class Project < ApplicationRecord

  has_many :memberships
  has_many :users, through: :memberships

  validates :title, presence: true
  validates :description, presence: true
end
