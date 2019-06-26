FactoryBot.define do

  factory :user, class: 'User' do
    sequence(:email)      { |n| (Faker::Internet.email).insert(1, n.to_s) }
    password              { 'password' }
    password_confirmation { 'password' }
    # role                  { 0 }
    # manager               { false }
  end

  # factory :admin, parent: :user do
  #   role                  { 2 }
  #   manager               { true }
  # end

end
