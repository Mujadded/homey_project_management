class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Roles enum
  enum :role, { member: "member", pm: "pm", admin: "admin" }, default: "member"

  # Associations
  has_many :project_events, dependent: :destroy

  # Validations
  validates :name, presence: true
  validates :role, presence: true
end
