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
      expect(page).to     have_content "Show User"
      expect(page).to     have_content "Current User: #{admin.email} -- #{admin.role}"

      expect(page).to     have_content "See User #{admin.id}: #{admin.email} -- role: #{admin.role}"
      expect(page).not_to have_link    "Delete User #{admin.id}", href: user_path(admin.id)

      # edit the other users
      users = User.all.reject { |u| u.email == admin.email }
      # pp page.body
      users.each do |u|
        expect(page).to   have_content "Edit User #{u.id}: #{u.email} -- role: #{u.role}"
        expect(page).to   have_link    "Delete User #{u.id}", href: user_path(u)
      end
    end
  end

  context 'User loged in as USER' do
    before do
      signin(user.email, user.password)
    end
    scenario 'has no access to users_index and redirected to home page' do
      visit users_path

      # expect(page).to have_content "<p hidden id='users_index' class='pageName'>"
      expect(page).to     have_content "Show User"
      expect(page).to     have_content "Current User: #{user.email} -- #{user.role}"
      expect(page).to     have_content "See User #{user.id}: #{user.email} -- role: #{user.role}"
      expect(page).not_to have_link    "Delete User #{user.id}", href: user_path(user.id)
      # doesn't see other users
      users = User.all.reject { |u| u.email == user.email }
      users.each do |u|
        expect(page).not_to have_content "See User #{u.id}: #{u.email} -- role: #{u.role}"
        expect(page).not_to have_link    "Delete User #{u.id}", href: user_path(u.id)
      end
    end
  end

end
