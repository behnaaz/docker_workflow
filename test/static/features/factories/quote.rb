FactoryGirl.define do
  factory :quote do
    text { Faker::Lorem.sentence }
  end
end