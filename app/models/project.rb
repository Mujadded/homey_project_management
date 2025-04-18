class Project < ApplicationRecord
  # Constants
  STATUSES = [ "Draft", "In Progress", "Blocked", "Completed" ].freeze

  # Associations
  has_many :project_events, dependent: :destroy

  # Validations
  validates :title, presence: true
  validates :status, presence: true, inclusion: { in: STATUSES }

  # Default values
  after_initialize :set_default_status, if: :new_record?

  private

  def set_default_status
    self.status ||= "Draft"
  end
end
