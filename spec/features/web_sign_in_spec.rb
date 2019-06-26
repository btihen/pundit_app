require 'rails_helper'

# RSpec.describe "Sigin", type: :feature do
feature 'SignIn', :devise do

  # include Devise::Test::IntegrationHelpers
  # include Features::SessionHelpers

  context 'User Sigin Failure' do
    scenario 'when not registered' do
      signin("no@email.com", "noPassword")
      expect(page).to have_content 'Invalid Email or password'
    end

    scenario 'with invalid email' do
      user = FactoryBot.create :user
      signin("invalid@email.com", user.password)
      expect(page).to have_content 'Invalid Email or password'
    end

    scenario 'with invalid email' do
      user = FactoryBot.create :user
      signin(user.email, 'InvalidPasswd')
      expect(page).to have_content 'Invalid Email or password'
    end
  end

  context 'User Sigin Success' do
    scenario 'with valid credentials' do
      user = FactoryBot.create :user
      signin(user.email, user.password)
      expect(page).to have_content 'Signed in successfully'
    end
  end

end
