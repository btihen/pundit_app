require 'rails_helper'

# RSpec.describe "Sigin", type: :feature do
feature 'User SHOW page', :devise do

  # include Devise::Test::IntegrationHelpers
  # include Features::SessionHelpers
  let!(:user)     { FactoryBot.create :user }
  let!(:admin)    { FactoryBot.create :user, :admin }

  context 'User loged in as ADMIN' do
    before do
      signin(admin.email, admin.password)
    end
    scenario 'has access - without edit link to own profile' do
      visit user_path(admin)

      expect(page).to have_content "Show #{admin.email}"
      expect(page).to have_content "User #{admin.id}: #{admin.email} -- role: #{admin.role}"
      expect(page).to have_content "Current User: #{admin.email} -- #{admin.role}"
    end
    scenario 'has access - with an edit link' do
      visit user_path(user)

      expect(page).to have_content "Show #{user.email}"
      expect(page).to have_link    "Edit User #{user.id}", href: "/users/#{user.id}/edit"
      expect(page).to have_content "Current User: #{admin.email} -- #{admin.role}"
    end
  end

  context 'User loged in as USER' do
    before do
      signin(user.email, user.password)
    end
    scenario 'has no access to admin_show page and redirected to home page' do
      visit user_path(admin)

      # expect(page).to have_content "<p hidden id='users_index' class='pageName'>"
      expect(page).to have_content "Home page"
      expect(page).to have_content "Access Denied"
    end
    scenario 'has access to user_show page - without an edit link' do
      visit user_path(user)

      # expect(page).to have_content "<p hidden id='users_index' class='pageName'>"
      expect(page).to have_content "Show #{user.email}"
      expect(page).to have_content "User #{user.id}: #{user.email} -- role: #{user.role}"
      expect(page).to have_content "Current User: #{user.email} -- #{user.role}"
    end
  end

end
