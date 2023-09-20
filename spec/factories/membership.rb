FactoryBot.define do
  factory :membership do
    user { create(:user) }
    project { create(:project) }
  end
end