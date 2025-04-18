# Homey Project Management

A project management system with conversation history, allowing users to comment on projects and track status changes.

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
git clone https://github.com/yourusername/homey_project_management.git
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

The application is ready to be deployed to Heroku. To enable automatic deployment:

1. Create Heroku apps for production and sandbox environments
2. Add HEROKU_API_KEY and HEROKU_EMAIL as GitHub repository secrets
3. Uncomment the deployment sections in .github/workflows/main.yml
4. Push to develop branch to deploy to sandbox, or main/master to deploy to production

## License

This project is available as open source under the terms of the MIT License.
