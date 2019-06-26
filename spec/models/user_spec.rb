require 'rails_helper'

describe User do

  context 'valid?' do
    it 'is "valid" with a default factory' do
      expect(FactoryBot.build(:user)).to be_valid
    end

    it 'is "invalid" without an email' do
      expect(FactoryBot.build(:user, email: nil)).not_to be_valid
    end
    it 'is "invalid" without a password' do
      expect(FactoryBot.build(:user, password: nil)).not_to be_valid
    end
    it 'is "invalid" when passwords do not match' do
      expect(FactoryBot.build(:user,
                              password: 'p4ss-word',
                              password_confirmation: 'P4SSW0RD5')
            ).not_to be_valid
    end
  end

end
