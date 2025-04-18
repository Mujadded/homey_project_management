class ProjectEvent < ApplicationRecord
  belongs_to :user
  belongs_to :project

  enum :event_type, { comment: "comment", status_change: "status_change" }

  validates :event_type, presence: true
  validates :content, presence: true, if: -> { comment? }
  validates :previous_status, presence: true, if: -> { status_change? }
  validates :new_status, presence: true, if: -> { status_change? }

  default_scope { order(created_at: :desc) }

  def author_name
    user.name
  end
end
