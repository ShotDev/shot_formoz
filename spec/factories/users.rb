# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    facebook_token "MyString"
    facebook_id "MyString"
  end
end
