FactoryGirl.define do
  factory :consumer do
    firstname { FFaker::Name.first_name }
    lastname { FFaker::Name.last_name }
  end
end
