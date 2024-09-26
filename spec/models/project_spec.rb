require "rails_helper"

RSpec.describe Project, type: :model do
  fixtures :users 
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
      project = Project.new(user: users(:estate_agent), name: "Project 1")
      project.save
      expect(project.project_statuses.count).to eq(1)
      expect(project.project_statuses.first.status).to eq("created")
    end

    it "create a status history record if it has changed" do
      project = Project.new(user: users(:estate_agent), name: "Project 1")
      project.save
      project.update(status: "in_progress")
      expect(project.project_statuses.count).to eq(2)
      expect(project.project_statuses.last.status).to eq("in_progress")
    end

  end
end
