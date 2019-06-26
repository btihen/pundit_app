require 'rails_helper'

describe UserPolicy do

  subject{ UserPolicy }

  # stubbed user to avoid db
  let(:user_1)  { FactoryBot.build_stubbed :user }
  let(:user_2)  { FactoryBot.build_stubbed :user }
  let(:admin)   { FactoryBot.build_stubbed :user, :admin }

  permissions :index? do
    it 'denies access if not an admin' do
      expect(UserPolicy).not_to permit(user_1)
    end
    it 'allows access if an admin user' do
      expect(UserPolicy).to     permit(admin)
    end
  end

  permissions :show? do
    it 'prevents other users from seeing their profile' do
      expect(subject).not_to   permit(user_1, user_2)
    end
    it 'allows a user to see their own profile' do
      expect(subject).to       permit(user_1, user_1)
    end
    it 'allows admin user to see all profiles' do
      expect(subject).to       permit(admin, user_1)
      expect(subject).to       permit(admin, user_2)
    end
  end

  permissions :destroy?, :edit?, :update? do
    it 'prevents normal users from updating other profiles' do
      expect(subject).not_to   permit(user_1, user_2)
    end
    it 'prevents normal users from updating their own profile' do
      expect(subject).not_to   permit(user_1, user_1)
    end
    it 'an admin from editing their own profile' do
      expect(subject).not_to   permit(admin, admin)
    end
    it 'allows admin user to edit other profiles' do
      expect(subject).to       permit(admin, user_1)
      expect(subject).to       permit(admin, user_2)
    end
  end

end
