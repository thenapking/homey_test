require "rails_helper"

RSpec.describe User, type: :model do
  describe "validations" do
    it { is_expected.to have_many(:projects).inverse_of(:user) }
    it { is_expected.to have_many(:project_comments).inverse_of(:user) }
    it { is_expected.to have_many(:project_statuses).inverse_of(:user) }
    it { is_expected.to define_enum_for(:role) }
    
  end
end
