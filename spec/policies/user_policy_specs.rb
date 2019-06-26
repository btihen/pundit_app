require 'rails_helper'

describe UserPolicy do

  subject{ UserPolicy }

  # stubbed user to avoid db
  let(:user_1)  { FactoryBot.build_stubbed :user }
  let(:user_2)  { FactoryBot.build_stubbed :user }
  let(:admin)   { FactoryBot.build_stubbed :user, :admin }

  permissions :index? do
    it 'denies access if not an admin' do
      expect(UserPolicy).not_to   permit(user)
    end
    it 'allows access if an admin user' do
      expect(UserPolicy).to       permit(user)
    end
  end

end
