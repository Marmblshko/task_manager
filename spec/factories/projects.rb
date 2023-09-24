FactoryBot.define do
  factory :project do
    sequence(:title) { |n| "#{n}_#{Faker::Lorem.words(number: 5).join(' ')}" }
    description { Faker::Lorem.paragraph }
    creator_id { create(:user).id }
    users_in_project { [] }

    trait :three_users_in_project do
      after(:create) do |project|
        users = create_list(:user, 3)
        project.update(users_in_project: users.pluck(:id))
      end
    end
  end
end
