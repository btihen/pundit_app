require 'rails_helper'

RSpec.describe "SignIn", type: :request do

  include Devise::Test::IntegrationHelpers

  # let!(:employee) { FactoryBot.create :user }
  # let!(:admin)    { FactoryBot.create :admin }

  context 'user not registered' do
    it 'can access login page' do
      get new_user_session_path

      expect(response).to           be_successful
      expect(response).to           have_http_status(200)
      expect(response.body).to      match "<p hidden id='login' class='pageName'></p>"
    end
    it 'can not login' do
      params = {email: 'not@registered.com', password: 'no_known_password'}
      get new_user_session_path, params: params

      expect(response).to           be_successful
      expect(response).to           have_http_status(200)
      expect(response.body).to      match "<p hidden id='login' class='pageName'></p>"
      # TODO: detect flash -- not logged in
      # expect(flash).to              match "Invalid Email or password"
    end
  end

  # context 'authenticated access as USER' do
  #   before(:each) do
  #     # when using confirmable - https://stackoverflow.com/questions/9482739/uncaught-throw-warden-in-devise-testing
  #     # attendee.confirmed_at = Time.zone.now
  #     # attendee.save
  #     sign_in employee
  #     # expect(warden.authenticated?(:user)).to be true
  #   end
  #   after(:each) do
  #     sign_out employee
  #     # expect(warden.authenticated?(:user)).to be false
  #   end
  #   it 'has access to "home" page - without an admin link' do
  #     get samurai.home_path
  #     expect(response).to           be_successful
  #     expect(response).to           have_http_status(200)
  #
  #     # check the resulting data - blocked not listed in index
  #     expect(response.body).to      match "<p hidden id='samurai_home' class='pageName'>"
  #     expect(response.body).not_to  match 'Admin'
  #     # TODO: add test that admin doesn't work
  #   end
  # end
  #
  # context 'authenticated access as ADMIN' do
  #   before(:each) do
  #     # when using confirmable -https://stackoverflow.com/questions/9482739/uncaught-throw-warden-in-devise-testing
  #     # attendee.confirmed_at = Time.zone.now
  #     # attendee.save
  #     sign_in admin
  #     # expect(warden.authenticated?(:user)).to be true
  #   end
  #   after(:each) do
  #     sign_out admin
  #     # expect(warden.authenticated?(:user)).to be false
  #   end
  #   it 'has access to "home" page - with an admin link' do
  #     get samurai.home_path
  #     expect(response).to           be_successful
  #     expect(response).to           have_http_status(200)
  #
  #     # check the resulting data - blocked not listed in index
  #     expect(response.body).to      match "<p hidden id='samurai_home' class='pageName'>"
  #     expect(response.body).to      match 'Admin'
  #     # TODO: add test that admin doesn't work
  #   end
  # end

end
