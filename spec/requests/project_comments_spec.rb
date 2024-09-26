require 'rails_helper'

RSpec.describe "Projects", type: :request do
  fixtures :users
  let(:user) { users(:estate_agent)}
  let(:project) { Project.create(name: "New Project", user: user) }


  context "when user is logged in" do
    before do
      sign_in users(:estate_agent)
    end

    describe "POST /projects/:project_id/project_comments" do
      it "creates a new comment for the project" do
        expect {
          post project_project_comments_path(project), params: { 
            project_comment: { comment: "This is a new comment." } 
          }
        }.to change(ProjectComment, :count).by(1)
  
        expect(response).to redirect_to(project_path(project))
        follow_redirect!
  
        expect(response.body).to include("This is a new comment.")
      end
    end
  end
end
