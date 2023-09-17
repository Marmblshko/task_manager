class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :memberships, dependent: :destroy
  has_many :projects, through: :memberships, dependent: :destroy

  validates :username, presence: true, uniqueness: true

  enum role: {
    User: 0,
    Moderator: 1,
    Admin: 2
  }, _default: :User

end
