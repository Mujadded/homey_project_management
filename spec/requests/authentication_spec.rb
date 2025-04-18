require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  describe 'GET /users/sign_in' do
    it 'returns a successful response' do
      get new_user_session_path
      expect(response).to be_successful
    end
  end

  describe 'POST /users/sign_in' do
    let!(:user) { create(:user, email: 'test@example.com', password: 'password123') }

    context 'with valid credentials' do
      it 'signs in the user' do
        post user_session_path, params: {
          user: {
            email: user.email,
            password: 'password123'
          }
        }

        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(response.body).to include('Signed in successfully')
      end
    end

    context 'with invalid credentials' do
      it 'does not sign in the user' do
        post user_session_path, params: {
          user: {
            email: user.email,
            password: 'wrongpassword'
          }
        }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('Invalid Email or password')
      end
    end
  end

  describe 'GET /users/sign_up' do
    it 'returns a successful response' do
      get new_user_registration_path
      expect(response).to be_successful
    end
  end

  describe 'POST /users' do
    context 'with valid parameters' do
      let(:valid_params) do
        {
          user: {
            name: 'New User',
            email: 'newuser@example.com',
            password: 'password123',
            password_confirmation: 'password123'
          }
        }
      end

      it 'creates a new user' do
        expect {
          post user_registration_path, params: valid_params
        }.to change(User, :count).by(1)

        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(response.body).to include('Welcome! You have signed up successfully')
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) do
        {
          user: {
            name: '',
            email: 'invalid-email',
            password: 'short',
            password_confirmation: 'different'
          }
        }
      end

      it 'does not create a new user' do
        expect {
          post user_registration_path, params: invalid_params
        }.not_to change(User, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("Email is invalid")
        expect(response.body).to include("Name can&#39;t be blank")
        expect(response.body).to include("Password is too short")
      end
    end
  end

  describe 'DELETE /users/sign_out' do
    let(:user) { create(:user) }

    it 'signs out the user' do
      sign_in user

      # First make a GET request to ensure the session is active
      get root_path
      expect(response).to be_successful

      # Then perform the sign out
      delete destroy_user_session_path

      # Should redirect to the root path
      expect(response).to redirect_to(root_path)

      # The user should no longer be authenticated
      get projects_path
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'authentication required' do
    it 'redirects to sign in page for protected resources' do
      get projects_path

      expect(response).to redirect_to(new_user_session_path)
      follow_redirect!
      expect(response.body).to include('You need to sign in or sign up before continuing')
    end
  end
end
