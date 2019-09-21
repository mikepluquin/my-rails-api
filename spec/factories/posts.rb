FactoryBot.define do
  factory :post do
    body { Faker::TvShows::GameOfThrones.quote }
    user
  end
end
