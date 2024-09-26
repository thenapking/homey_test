class ProjectStatus < ApplicationRecord
  belongs_to :user, inverse_of: :project_statuses
  belongs_to :project, inverse_of: :project_statuses

  enum status: Constants::STATUSES

  validates :status, presence: true


end
