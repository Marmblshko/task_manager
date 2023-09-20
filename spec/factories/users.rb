FactoryBot.define do
  factory :user do
    sequence(:username) {|n| "#{n}_#{Faker::JapaneseMedia::CowboyBebop.character}" }
    email { Faker::Internet.email }
    password { 123123 }
    password_confirmation { 123123 }
    role { 'User' }
  end

  trait :moderator do
    role { 'Moderator' }
  end

  trait :admin do
    role { 'Admin' }
  end
end
