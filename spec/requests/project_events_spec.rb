require 'rails_helper'

RSpec.describe "/project_events", type: :request do
  let(:user) { User.create!(name: 'Test User', email: 'test_events@example.com', password: 'password123', role: 'member') }
  let(:project) { Project.create!(title: 'Test Project', description: 'Test Description', status: 'Draft') }

  let(:valid_attributes) {
    { content: "This is a test comment" }
  }

  let(:invalid_attributes) {
    { content: "" }
  }

  describe "POST /create" do
    context "when not authenticated" do
      it "redirects to login page" do
        post project_project_events_url(project), params: { project_event: valid_attributes }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "with valid parameters" do
      it "creates a new comment and redirects to the project" do
        sign_in user
        expect {
          post project_project_events_url(project), params: { project_event: valid_attributes }
        }.to change(ProjectEvent, :count).by(1)

        expect(response).to redirect_to(project_url(project))
        expect(flash[:notice]).to eq(I18n.t("project_events.create.success"))

        # Verify the comment details
        event = ProjectEvent.last
        expect(event.user).to eq(user)
        expect(event.project).to eq(project)
        expect(event.event_type).to eq("comment")
        expect(event.content).to eq(valid_attributes[:content])
      end
    end

    context "with invalid parameters" do
      it "does not create a new comment and redirects with an alert" do
        sign_in user
        expect {
          post project_project_events_url(project), params: { project_event: invalid_attributes }
        }.not_to change(ProjectEvent, :count)

        expect(response).to redirect_to(project_url(project))
        expect(flash[:alert]).to eq(I18n.t("project_events.create.failure"))
      end
    end
  end
end
