require 'rails_helper'

RSpec.describe "Project Conversations", type: :system do
  let!(:admin) { User.find_by(email: 'admin@example.com') || User.create!(name: 'Admin User', email: 'admin@example.com', password: 'password123', role: 'admin') }
  let!(:pm) { User.find_by(email: 'pm@example.com') || User.create!(name: 'Project Manager', email: 'pm@example.com', password: 'password123', role: 'pm') }
  let!(:member) { User.find_by(email: 'member@example.com') || User.create!(name: 'Team Member', email: 'member@example.com', password: 'password123', role: 'member') }
  let!(:project) { Project.find_by(title: 'Website Redesign') || Project.create!(title: 'Website Redesign', description: 'Redesigning the company website', status: 'Draft') }

  before do
    driven_by(:selenium_chrome_headless)
  end

  describe "Project view" do
    context "as admin user" do
      it "allows viewing and commenting on projects" do
        visit new_user_session_path

        # Fill in login details and submit
        within('form') do
          fill_in "Email", with: admin.email
          fill_in "Password", with: "password123"
          # Find the submit button by its text value and click it
          click_button "Sign in"
        end

        # Verify successful login
        expect(page).to have_content(admin.name)

        # Visit the project page
        visit project_path(project)

        # Check that we're on the right page
        expect(page).to have_content(project.title)

        # Add a comment
        comment_text = "This is a test comment from admin"
        fill_in "Add a comment", with: comment_text
        click_button "Post Comment"

        expect(page).to have_content(comment_text)
        expect(page).to have_content(admin.name)
      end

      it "allows changing project status" do
        # Sign in first
        visit new_user_session_path
        within('form') do
          fill_in "Email", with: admin.email
          fill_in "Password", with: "password123"
          click_button "Sign in"
        end

        # Verify successful login
        expect(page).to have_content(admin.name)

        visit project_path(project)

        # Find a status button that isn't the current status and click it
        new_status = (Project::STATUSES - [ project.status ]).first
        find('button', text: new_status).click

        expect(page).to have_content("Project status was successfully updated")
        expect(page).to have_content("Status changed from")
      end
    end

    context "as member user" do
      it "allows viewing and commenting but not changing status" do
        # Sign in first
        visit new_user_session_path
        within('form') do
          fill_in "Email", with: member.email
          fill_in "Password", with: "password123"
          click_button "Sign in"
        end

        # Verify successful login
        expect(page).to have_content(member.name)

        visit project_path(project)
        expect(page).to have_content(project.title)

        # Add a comment
        comment_text = "This is a test comment from member"
        fill_in "Add a comment", with: comment_text
        click_button "Post Comment"

        expect(page).to have_content(comment_text)
        expect(page).to have_content(member.name)

        # Should not see status change buttons
        expect(page).not_to have_content("Change status:")
      end
    end
  end
end
