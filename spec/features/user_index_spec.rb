require 'rails_helper'

# RSpec.describe "Sigin", type: :feature do
feature 'User index page', :devise do

  # include Devise::Test::IntegrationHelpers
  # include Features::SessionHelpers
  let!(:user)     { FactoryBot.create :user }
  let!(:admin)    { FactoryBot.create :user, :admin }

  context 'User loged in as ADMIN' do
    before do
      signin(admin.email, admin.password)
    end
    scenario 'sees own email address' do
      visit users_path

      # capybara - by default doesn't seen hidden things
      # expect(page).to have_content "<p hidden id='users_index' class='pageName'>"
      expect(page).to have_content "Show all Users"
      expect(page).to have_content "Current User: #{admin.email} -- #{admin.role}"
    end
    scenario 'has access to admin_show page' do
      visit user_path(admin)

      # expect(page).to have_content "<p hidden id='users_index' class='pageName'>"
      expect(page).to have_content "Show #{admin.email}"
      expect(page).to have_content "Current User: #{admin.email} -- #{admin.role}"
    end
    scenario 'has access to user_show page' do
      # user = FactoryBot.create :user
      # signin(user.email, user.password)
      visit user_path(user)

      # expect(page).to have_content "<p hidden id='users_index' class='pageName'>"
      expect(page).to have_content "Show #{user.email}"
      expect(page).to have_content "Current User: #{admin.email} -- #{admin.role}"
    end
  end

  context 'User loged in as USER' do
    before do
      signin(user.email, user.password)
    end
    scenario 'has no access to users_index and redirected to home page' do
      visit users_path

      # expect(page).to have_content "<p hidden id='users_index' class='pageName'>"
      expect(page).to have_content "Home page"
      expect(page).to have_content "Access Denied"
    end
    scenario 'has no access to admin_show page and redirected to home page' do
      visit user_path(admin)

      # expect(page).to have_content "<p hidden id='users_index' class='pageName'>"
      expect(page).to have_content "Home page"
      expect(page).to have_content "Access Denied"
    end
    scenario 'has access to user_show page' do
      visit user_path(user)

      # expect(page).to have_content "<p hidden id='users_index' class='pageName'>"
      expect(page).to have_content "Show #{user.email}"
      expect(page).to have_content "Current User: #{user.email} -- #{user.role}"
    end
  end

end
