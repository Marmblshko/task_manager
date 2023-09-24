FactoryBot.define do
  factory :membership do
    user { association(:user) }
    project { association(:project) }
  end
end
