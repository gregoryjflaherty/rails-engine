FactoryBot.define do
  factory :item do
    name { Faker::Cannabis.strain }
    description { Faker::Cannabis.health_benefit }
    unit_price { Faker::Number.within(range: 10.0..20.0) }
    merchant
  end
end
