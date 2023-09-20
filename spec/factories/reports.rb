FactoryBot.define do
  factory :report do
    title { Faker::Lorem.words(number: 4).join(' ') }
    description { Faker::Lorem.paragraph }
    task { create(:task) }
    creator_username { create(:user).username }
    creator_id { create(:user).id }
  end
end
