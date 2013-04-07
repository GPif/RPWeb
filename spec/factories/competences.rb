# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :competence do
    name "MyString"
    characteristic "MyString"
    base false
    description "MyText"
  end
end
