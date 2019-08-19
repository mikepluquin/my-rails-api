FactoryBot.define do
  factory :post do
    body { Faker::Movies::StarWars.quote }
    user
  end
end
