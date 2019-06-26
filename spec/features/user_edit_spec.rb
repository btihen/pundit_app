require 'rails_helper'

# RSpec.describe "Sigin", type: :feature do
feature 'User Edit page', :devise do

  # include Devise::Test::IntegrationHelpers
  # include Features::SessionHelpers
  let!(:user)     { FactoryBot.create :user }
  let!(:admin)    { FactoryBot.create :user, :admin }

  context 'User loged in as ADMIN' do
    before do
      signin(admin.email, admin.password)
    end
    scenario 'has no access to edit admin page' do
      visit edit_user_path(admin)

      expect(page).to have_content "Home page"
      expect(page).to have_content "Access Denied"
    end
    scenario 'has access to edit user page' do
      # user = FactoryBot.create :user
      # signin(user.email, user.password)
      visit edit_user_path(user)

      expect(page).to have_content "Edit #{user.email}"
      expect(page).to have_link    "User #{user.id}", href: "/users/#{user.id}"
      expect(page).to have_content "#{user.email} -- role: user"
      expect(page).to have_content "Current User: #{admin.email} -- #{admin.role}"

      # change role from user to editor
      select('editor', :from => 'Role')
      click_button('Update Role')

      expect(page).to have_content "Show #{user.email}"
      expect(page).to have_link    "Edit User #{user.id}", href: "/users/#{user.id}/edit"
      expect(page).to have_content "#{user.email} -- role: editor"
      expect(page).to have_content "Current User: #{admin.email} -- #{admin.role}"
    end
  end

  context 'User loged in as USER' do
    before do
      signin(user.email, user.password)
    end
    scenario 'has no access to admin_show page and redirected to home page' do
      visit edit_user_path(admin)

      # expect(page).to have_content "<p hidden id='users_index' class='pageName'>"
      expect(page).to have_content "Home page"
      expect(page).to have_content "Access Denied"
    end
    scenario 'has no access to edit user page' do
      visit edit_user_path(user)

      expect(page).to have_content "Home page"
      expect(page).to have_content "Access Denied"
    end
  end

end
