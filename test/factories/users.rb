# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    phone 9254131387
    email { Faker::Internet.email }
    password "password"
  end
end
