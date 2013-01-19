# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tag do
    tag_code 1
    location { Faker::Address.street_address }
    user_id 1
  end
end
