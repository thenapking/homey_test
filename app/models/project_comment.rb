class ProjectComment < ApplicationRecord
  belongs_to :user, inverse_of: :project_comments
  belongs_to :project, inverse_of: :project_comments

  validates :comment, presence: true
end
