class Project < ApplicationRecord
  has_many :project_comments, inverse_of: :project, dependent: :destroy
  has_many :project_statuses, inverse_of: :project, dependent: :destroy
  belongs_to :user, inverse_of: :projects

  enum status: Constants::STATUSES

  validates :name, presence: true
  validates :status, presence: true

  after_create :create_status_history
  after_update :update_status_history

  private
    def create_status_history
      ProjectStatus.create(user: user, project: self, status: 0)
    end

    def update_status_history
      return unless saved_change_to_status?

      ProjectStatus.create(user: user, project: self, status: status)
    end

end
