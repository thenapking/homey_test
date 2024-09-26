require "rails_helper"

RSpec.describe Project, type: :model do
  subject(:project) { described_class.new }

  describe "validations" do
    it { is_expected.to belong_to(:user).inverse_of(:projects).required }
    it { is_expected.to have_many(:project_comments).inverse_of(:project).dependent(:destroy) }
    it { is_expected.to have_many(:project_statuses).inverse_of(:project).dependent(:destroy) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to define_enum_for(:status).with_values(Constants::STATUSES) }
  end

  describe "callbacks" do
    it "creates a status history after creation" do

    end

  end
end
