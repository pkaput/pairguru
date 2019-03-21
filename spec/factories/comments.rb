FactoryBot.define do
  factory :comment do
    text { Faker::Lorem.word }
    created_at { Faker::Date.between(1.week.ago, Time.zone.today) }
    movie
    user
  end
end
