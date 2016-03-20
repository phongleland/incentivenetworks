FactoryGirl.define do
  factory :transaction do
    sale_date { Faker::Date.backward(14) }
    sale_amount { Faker::Commerce.price }
    consumer
    merchant
  end
end
