require 'rails_helper'

RSpec.describe 'Authentication', type: :system do
  before do
    driven_by(:rack_test)
  end

  describe 'sign up' do
    it 'allows a new user to sign up' do
      visit new_user_registration_path

      fill_in 'Name', with: 'Test User'
      fill_in 'Email', with: 'test@example.com'
      fill_in 'Password', with: 'password123'
      fill_in 'Password confirmation', with: 'password123'

      expect { click_button 'Sign up' }.to change(User, :count).by(1)

      expect(page).to have_current_path(root_path)
      expect(page).to have_content('Welcome! You have signed up successfully.')

      # Check that the user was created with the correct attributes
      user = User.last
      expect(user.name).to eq('Test User')
      expect(user.email).to eq('test@example.com')
      expect(user.role).to eq('member')
    end

    it 'shows validation errors when sign up data is invalid' do
      visit new_user_registration_path

      # Submit without filling in any fields
      click_button 'Sign up'

      expect(page).to have_content("Email can't be blank")
      expect(page).to have_content("Password can't be blank")
      expect(page).to have_content("Name can't be blank")
      expect(User.count).to eq(0)
    end
  end

  describe 'sign in' do
    let!(:user) { create(:user, email: 'user@example.com', password: 'password123') }

    it 'allows user to sign in with valid credentials' do
      visit new_user_session_path

      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'password123'
      click_button 'Sign in'

      expect(page).to have_current_path(root_path)
      expect(page).to have_content('Signed in successfully.')
    end

    it 'shows error with invalid credentials' do
      visit new_user_session_path

      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'wrongpassword'
      click_button 'Sign in'

      expect(page).to have_content('Invalid Email or password.')
      expect(page).to have_current_path(new_user_session_path)
    end
  end

  describe 'sign out' do
    let!(:user) { create(:user) }

    it 'allows signed in user to sign out' do
      sign_in user
      visit root_path

      expect(page).to have_content(user.name)  # Verify user is signed in

      click_button 'Sign Out'

      # Verify user is redirected to sign in page
      expect(page).to have_current_path(new_user_session_path)
      expect(page).to have_content("Sign in")
      expect(page).not_to have_content(user.name)
    end
  end

  describe 'authentication required' do
    it 'redirects to sign in page when accessing protected resources' do
      visit projects_path

      expect(page).to have_current_path(new_user_session_path)
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end
  end

  describe 'navigation links' do
    it 'has a link from sign in to sign up page' do
      visit new_user_session_path

      click_link 'Sign up'

      expect(page).to have_current_path(new_user_registration_path)
    end

    it 'has a link from sign up to sign in page' do
      visit new_user_registration_path

      click_link 'Sign in'

      expect(page).to have_current_path(new_user_session_path)
    end
  end
end
