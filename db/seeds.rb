# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Create admin user
admin = User.create!(
  name: "Admin User",
  email: "admin@example.com",
  password: "password123",
  role: "admin"
)

# Create project manager
pm = User.create!(
  name: "Project Manager",
  email: "pm@example.com",
  password: "password123",
  role: "pm"
)

# Create regular member
member = User.create!(
  name: "Team Member",
  email: "member@example.com",
  password: "password123",
  role: "member"
)

# Create projects
project1 = Project.create!(
  title: "Website Redesign",
  description: "Modernize the company website with new design and improved user experience.",
  status: "In Progress"
)

project2 = Project.create!(
  title: "Mobile App Development",
  description: "Create a mobile app for our customers to access our services on the go.",
  status: "Draft"
)

project3 = Project.create!(
  title: "Data Migration",
  description: "Migrate data from legacy systems to our new cloud platform.",
  status: "Blocked"
)

# Create project events
# Comments
ProjectEvent.create!(
  project: project1,
  user: admin,
  event_type: "comment",
  content: "We need to focus on improving the mobile experience."
)

ProjectEvent.create!(
  project: project1,
  user: pm,
  event_type: "comment",
  content: "I've scheduled a meeting with the design team for next week."
)

ProjectEvent.create!(
  project: project1,
  user: member,
  event_type: "comment",
  content: "The initial wireframes are ready for review."
)

# Status changes
ProjectEvent.create!(
  project: project1,
  user: pm,
  event_type: "status_change",
  previous_status: "Draft",
  new_status: "In Progress"
)

ProjectEvent.create!(
  project: project2,
  user: admin,
  event_type: "comment",
  content: "We should get started on this soon. It's a high priority for Q3."
)

ProjectEvent.create!(
  project: project3,
  user: pm,
  event_type: "status_change",
  previous_status: "In Progress",
  new_status: "Blocked"
)

ProjectEvent.create!(
  project: project3,
  user: pm,
  event_type: "comment",
  content: "We're blocked due to issues with the legacy database structure."
)
