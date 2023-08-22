FactoryBot.define do
  factory :task do
    title {'Tester 1'}
    description {'Tester1@example.com'}
    status {0}
    project_id {1}
  end
end