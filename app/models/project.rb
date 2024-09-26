class Project < ApplicationRecord
  has_many :project_comments, inverse_of: :project, dependent: :destroy
  has_many :project_statuses, inverse_of: :project, dependent: :destroy
  belongs_to :user, inverse_of: :projects

  enum status: Constants::STATUSES

end
