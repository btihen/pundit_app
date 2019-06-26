require 'rails_helper'

RSpec.describe "Users Index", type: :request do

  include Devise::Test::IntegrationHelpers

  let!(:user)     { FactoryBot.create :user }
  let!(:editor)   { FactoryBot.create :user, :editor }
  let!(:admin)    { FactoryBot.create :user, :admin }

  context 'unauthenticated access' do
    it 'redirects to the sign-in page' do
      get users_path

      expect(response).to           have_http_status(302)
      expect(response).to           redirect_to(new_user_session_path)
      expect(response.body).to      match "<body>You are being <a href=\"#{request.base_url}/users/sign_in\">redirected</a>"
      follow_redirect!
      expect(response).to           be_successful
      expect(response).to           have_http_status(200)
      expect(response.body).to      match "<p hidden id='login' class='pageName'></p>"
    end
  end

  context 'authenticated access as User' do
    before(:each) do
      # when using confirmable - https://stackoverflow.com/questions/9482739/uncaught-throw-warden-in-devise-testing
      # attendee.confirmed_at = Time.zone.now
      # attendee.save
      sign_in user
      # expect(warden.authenticated?(:user)).to be true
    end
    after(:each) do
      sign_out user
      # expect(warden.authenticated?(:user)).to be false
    end
    it 'has access to "home" page - without an admin link' do
      get users_path

      expect(response).to           be_successful
      expect(response).to           have_http_status(200)

      # check the resulting data
      expect(response.body).to      match "<p hidden id='users_index' class='pageName'>"
      expect(response.body).to      match "Show User"
      expect(response.body).to      match "Current User: #{user.email} -- #{user.role}"

      expect(response.body).to      match "See User #{user.id}"
      expect(response.body).not_to  match "Delete User #{user.id}"
    end
  end

  context 'authenticated access as ADMIN' do
    before(:each) do
      # when using confirmable -https://stackoverflow.com/questions/9482739/uncaught-throw-warden-in-devise-testing
      # attendee.confirmed_at = Time.zone.now
      # attendee.save
      sign_in admin
      # expect(warden.authenticated?(:user)).to be true
    end
    after(:each) do
      sign_out admin
      # expect(warden.authenticated?(:user)).to be false
    end
    it 'has access to "home" page - with an admin link' do
      get users_path
      expect(response).to           be_successful
      expect(response).to           have_http_status(200)

      # check the resulting data - blocked not listed in index
      expect(response.body).to      match "<p hidden id='users_index' class='pageName'>"
      expect(response.body).to      match "Show User"
      expect(response.body).to      match "Current User: #{admin.email} -- #{admin.role}"

      expect(response.body).to      match "See User #{admin.id}"
      expect(response.body).not_to  match "Delete User #{admin.id}"

      expect(response.body).to      match "Edit User #{user.id}"
      expect(response.body).to      match "Delete User #{user.id}"
    end
  end

end
