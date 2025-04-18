# Homey Project Management

A project management system with conversation history, allowing users to comment on projects and track status changes.

## Live Demo

- GitHub Repository: [https://github.com/Mujadded/homey_project_management](https://github.com/Mujadded/homey_project_management)
- Live Application: [https://homey-project-mgmt-prod-994ca5a27e81.herokuapp.com/](https://homey-project-mgmt-prod-994ca5a27e81.herokuapp.com/)

## Features

- User authentication with role-based access control (admin, project manager, team member)
- Project creation and management
- Conversation history with comments and status changes
- Timeline of all project events
- Pagination for project conversation history
- Responsive design with Tailwind CSS

## Technology Stack

- Ruby 3.3.2
- Rails 8.0.1
- PostgreSQL
- Devise for authentication
- Tailwind CSS for styling
- Slim for templates
- RSpec for testing
- GitHub Actions for CI/CD

## Development Setup

### Prerequisites

- Ruby 3.3.2
- PostgreSQL
- Node.js (for Tailwind CSS)

### Installation

1. Clone the repository
```
git clone https://github.com/Mujadded/homey_project_management.git
cd homey_project_management
```

2. Install dependencies
```
bundle install
```

3. Setup the database
```
rails db:create db:migrate db:seed
```

4. Start the server
```
bin/dev
```

5. Visit http://localhost:3000 in your browser

### Test Users

- Admin: admin@example.com / password123
- Project Manager: pm@example.com / password123
- Team Member: member@example.com / password123

## Testing

Run the test suite with:
```
bundle exec rspec
```

## CI/CD Pipeline

The project uses GitHub Actions for continuous integration and deployment:

- Tests run automatically on push to main, master, and develop branches
- Code linting with RuboCop ensures code quality
- Automated deployment to Heroku (when configured)

## Deployment

The application is deployed to Heroku. The CI/CD pipeline automatically deploys changes from the main branch to the production environment.

- Production URL: [https://homey-project-mgmt-prod-994ca5a27e81.herokuapp.com/](https://homey-project-mgmt-prod-994ca5a27e81.herokuapp.com/)

## License

This project is available as open source under the terms of the MIT License.
