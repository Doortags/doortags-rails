# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tag do
    tag_code 1
    location "MyString"
    user_id 1
  end
end
