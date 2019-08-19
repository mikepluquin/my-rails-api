FactoryBot.define do
  factory :message do
    user { nil }
    conversation { nil }
    body { "MyText" }
    read { false }
  end
end
