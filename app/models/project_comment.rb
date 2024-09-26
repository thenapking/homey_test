class ProjectComment < ApplicationRecord
  belongs_to :user, inverse_of: :project_comments
  belongs_to :project, inverse_of: :project_comments
end
