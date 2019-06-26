require 'rails_helper'

# RSpec.describe "Sigin", type: :feature do
feature 'User index page', :devise do

  # include Devise::Test::IntegrationHelpers
  # include Features::SessionHelpers

  context 'User loged in as ADMIN' do
    scenario 'sees own email address' do
      admin = FactoryBot.create(:user, :admin)
      signin(admin.email, admin.password)
      visit users_path

      # capybara - by default doesn't seen hidden things
      # expect(page).to have_content "<p hidden id='users_index' class='pageName'>"
      expect(page).to have_content "Show all Users"
      expect(page).to have_content "Current User: #{admin.email} -- #{admin.role}"
    end
  end

  context 'User loged in as USER' do
    scenario 'has no access and redirected to home page' do
      user = FactoryBot.create :user
      signin(user.email, user.password)
      visit users_path

      # expect(page).to have_content "<p hidden id='users_index' class='pageName'>"
      expect(page).to have_content "Home page"
      expect(page).to have_content "Access Denied"
    end
  end

end
