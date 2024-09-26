require "rails_helper"

RSpec.describe ProjectComment, type: :model do
  describe "validations" do
    it { is_expected.to belong_to(:user).inverse_of(:project_comments).required }
    it { is_expected.to belong_to(:project).inverse_of(:project_comments).required }
    it { is_expected.to validate_presence_of(:comment) }
  end
end
