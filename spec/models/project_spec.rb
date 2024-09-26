require "rails_helper"

RSpec.describe Project, type: :model do
  subject(:project) { described_class.new }

  describe "validations" do
    it { is_expected.to belong_to(:user).inverse_of(:projects) }
    it { is_expected.to have_many(:project_comments).inverse_of(:project) }
    it { is_expected.to have_many(:project_statuses).inverse_of(:project) }
  end
end
