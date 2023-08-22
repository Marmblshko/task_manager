FactoryBot.define do
  factory :user do
    username {'Tester 1'}
    email {'Tester1@example.com'}
    password {123123}
    password_confirmation {123123}
  end
end