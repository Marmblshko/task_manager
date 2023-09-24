FactoryBot.define do
  factory :task do
    title { Faker::Lorem.words(number: 7).join(' ') }
    description { Faker::Lorem.paragraph }
    status { 'Fresh' }
    project { association(:project) }
  end

  trait :task_working do
    status { 'Working' }
  end

  trait :task_completed do
    status { 'Completed' }
  end
end
