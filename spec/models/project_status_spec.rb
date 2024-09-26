require "rails_helper"

RSpec.describe ProjectStatus, type: :model do
  describe "validations" do
    it { is_expected.to belong_to(:user).inverse_of(:project_statuses).required }
    it { is_expected.to belong_to(:project).inverse_of(:project_statuses).required }
    it { is_expected.to validate_presence_of(:status) }
  end
end
