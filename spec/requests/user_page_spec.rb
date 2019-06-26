require 'rails_helper'

RSpec.describe "Contacts", type: :request do

  include Devise::Test::IntegrationHelpers

  let!(:user)     { FactoryBot.create :user }
  let!(:editor)   { FactoryBot.create :user, :editor }
  let!(:admin)    { FactoryBot.create :user, :admin }

  context 'unauthenticated access' do
    xit 'redirects to the sign-in page' do
      get samurai.home_path
      expect(response).to           have_http_status(302)
      expect(response).to           redirect_to(new_user_session_path)
      expect(response.body).to      match "<body>You are being <a href=\"#{request.base_url}/samurai/users/sign_in\">redirected</a>"
      follow_redirect!
      expect(response).to           be_successful
      expect(response).to           have_http_status(200)

      # check the resulting data
      expect(response.body).to      match "<p hidden id='signin' class='pageName'></p>"
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

      expect(response.body).to      match "<p hidden id='users_index' class='pageName'>"
      expect(response.body).to      match user.email
      expect(response.body).to      match user.role
    end
  end

  context 'authenticated access as EDITOR' do
    before(:each) do
      # when using confirmable - https://stackoverflow.com/questions/9482739/uncaught-throw-warden-in-devise-testing
      # attendee.confirmed_at = Time.zone.now
      # attendee.save
      sign_in editor
      # expect(warden.authenticated?(:user)).to be true
    end
    after(:each) do
      sign_out editor
      # expect(warden.authenticated?(:user)).to be false
    end
    it 'has access to "home" page - without an admin link' do
      get users_path
      expect(response).to           be_successful
      expect(response).to           have_http_status(200)

      # check the resulting data - blocked not listed in index
      expect(response.body).to      match "<p hidden id='users_index' class='pageName'>"
      expect(response.body).to      match editor.email
      expect(response.body).to      match editor.role
      # TODO: add test that admin doesn't work
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
      expect(response.body).to      match admin.email
      expect(response.body).to      match admin.role
    end
  end

end
