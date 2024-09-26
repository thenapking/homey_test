require 'rails_helper'

RSpec.describe "Projects", type: :request do
  fixtures :users
  let(:user) { users(:estate_agent)}
  let(:project) { Project.create(name: "New Project", user: user) }

  context "when user is not logged in" do
    it "redirects to the login page" do
      get "/projects/index"
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context "when user is logged in" do
    before do
      sign_in users(:estate_agent)
    end

    describe "GET /index" do
      it "returns http success" do
        get "/projects/index"
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET /show" do
      it "returns http success" do
        get project_path(project)
        expect(response).to have_http_status(:success)
      end

      it "displays the project info" do
        get project_path(project)
        expect(response.body).to include("New Project")
        expect(response.body).to include("Created")
      end

      it "displays comments" do
        first_comment = project.project_comments.create(comment: "First comment", user: user)
        second_comment = project.project_comments.create(comment: "Second comment", user: users(:buyer))
        get project_path(project)
        expect(response.body).to include("First comment")
        expect(response.body).to include("Second comment")
        expect(response.body).to include("Jane Foxton")
        expect(response.body).to include("John Doe")
      end
    end

    describe "GET /new" do
      it "returns http success" do
        get new_project_path
        expect(response).to have_http_status(:success)
      end
    end

    describe "POST /create" do
      it "creates a new project" do
        expect {
          post projects_path, params: { project: { name: "New Project"} }
        }.to change(Project, :count).by(1)
      end
  
      it "redirects to the new project" do
        post projects_path, params: { project: { name: "New Project"} }
        expect(response).to redirect_to(project_path(Project.last))
      end
    end

    describe "GET /edit" do
      it "returns a success response" do
        get edit_project_path(project)
        expect(response).to have_http_status(:ok)
      end
    end

    describe "PATCH /update" do
      it "updates the project" do
        patch project_path(project), params: { project: { name: "Updated Project Name" } }
        project.reload
        expect(project.name).to eq("Updated Project Name")
      end
  
      it "redirects to the project" do
        patch project_path(project), params: { project: { name: "Updated Project Name" } }
        expect(response).to redirect_to(project_path(project))
      end

      it "displays errors" do
        patch project_path(project), params: { project: { name: "" } }
        expect(response.body).to include("1 error prohibited this project from being saved")
      end

      it "allows the user to update the status" do
        patch project_path(project), params: { project: { status: "completed" } }
        project.reload
        expect(project.status).to eq("completed")
        expect(project.project_statuses.count).to eq(2)
        expect(project.project_statuses.last.user).to eq(user)
      end
    end
  
    describe "DELETE /destroy" do
      it "destroys the project" do
        project.touch
        expect {
          delete project_path(project)
        }.to change(Project, :count).by(-1)
      end
  
      it "redirects to the projects list" do
        delete project_path(project)
        expect(response).to redirect_to(projects_path)
      end
    end
  end
end
