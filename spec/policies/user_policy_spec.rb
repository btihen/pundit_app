require 'rails_helper'

describe UserPolicy do

  subject{ UserPolicy }

  # stubbed user to avoid db
  let(:user_1)    { FactoryBot.build_stubbed :user }
  let(:user_2)    { FactoryBot.build_stubbed :user }
  let(:admin)     { FactoryBot.build_stubbed :user, :admin }
  let(:adm_scope) { Pundit.policy_scope!(admin, User) }
  let(:usr_scope) { Pundit.policy_scope!(user_1, User) }
  # let(:adm_scope) { UserPolicy::UserIndexScope.new(admin, User).resolve }
  # let(:usr_scope) { UserPolicy::UserIndexScope.new(user_1, User).resolve }

  describe "UserIndexScope" do
    it 'user_1 gets subset of self' do
      expect(usr_scope.to_a).to match_array( User.where(id: user_1.id).to_a )
    end
    it 'admin gets all users' do
      expect(adm_scope.to_a).to match_array( User.all.to_a )
    end
  end

  permissions :index? do
    it 'denies access if not an admin' do
      expect(UserPolicy).to     permit(user_1)
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
