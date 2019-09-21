FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    username { Faker::TvShows::GameOfThrones.character }
    password { Faker::Alphanumeric.alphanumeric(number: 10) }
    born_date { Faker::Date.birthday(min_age: 18, max_age: 65) }
  end
end
