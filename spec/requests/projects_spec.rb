require 'rails_helper'

RSpec.describe "/projects", type: :request do
  let(:admin) { User.create!(name: 'Admin User', email: 'admin_test@example.com', password: 'password123', role: 'admin') }
  let(:member) { User.create!(name: 'Member User', email: 'member_test@example.com', password: 'password123', role: 'member') }

  let(:valid_attributes) {
    { title: "Test Project", description: "A test project description", status: "Draft" }
  }

  let(:invalid_attributes) {
    { title: "", description: "A test project description", status: "Invalid" }
  }

  describe "GET /index" do
    it "requires authentication" do
      get projects_url
      expect(response).to redirect_to(new_user_session_path)
    end

    it "renders a successful response when authenticated" do
      sign_in admin
      get projects_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "requires authentication" do
      project = Project.create!(valid_attributes)
      get project_url(project)
      expect(response).to redirect_to(new_user_session_path)
    end

    it "renders a successful response when authenticated" do
      sign_in admin
      project = Project.create!(valid_attributes)
      get project_url(project)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "requires authentication" do
      get new_project_url
      expect(response).to redirect_to(new_user_session_path)
    end

    it "renders a successful response when authenticated" do
      sign_in admin
      get new_project_url
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Project and redirects to the project" do
        sign_in admin
        expect {
          post projects_url, params: { project: valid_attributes }
        }.to change(Project, :count).by(1)

        expect(response).to redirect_to(project_url(Project.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Project and renders the new template" do
        sign_in admin
        expect {
          post projects_url, params: { project: invalid_attributes }
        }.not_to change(Project, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /projects/:id/status" do
    let(:project) { Project.create!(valid_attributes) }

    context "when user is admin" do
      it "updates the project status" do
        sign_in admin
        patch update_project_status_path(project), params: { status: "In Progress" }

        project.reload
        expect(project.status).to eq("In Progress")
        expect(response).to redirect_to(project_url(project))
      end

      it "creates a status_change event" do
        sign_in admin
        expect {
          patch update_project_status_path(project), params: { status: "In Progress" }
        }.to change(ProjectEvent, :count).by(1)

        event = ProjectEvent.last
        expect(event.event_type).to eq("status_change")
        expect(event.previous_status).to eq("Draft")
        expect(event.new_status).to eq("In Progress")
      end
    end

    context "when user is regular member" do
      it "does not allow status changes" do
        sign_in member
        patch update_project_status_path(project), params: { status: "In Progress" }

        project.reload
        expect(project.status).not_to eq("In Progress")
        expect(response).to redirect_to(project_url(project))
        expect(flash[:alert]).to eq(I18n.t("projects.authorization.failure"))
      end
    end
  end
end
