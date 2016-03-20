FactoryGirl.define do
  factory :merchant do
    name { FFaker::Company.name }
    domain { FFaker::Internet.domain_name }
  end
end
