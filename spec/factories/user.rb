FactoryBot.define do

  factory :user, class: 'User' do
    sequence(:email)      { |n| (Faker::Internet.email).insert(1, n.to_s) }
    password              { 'password' }
    password_confirmation { 'password' }
    # role                  { 'users' }
  end

  trait :editor do
    role                  { 'editor' }
  end

  trait :admin do
    role                  { 'admin' }
  end

end
