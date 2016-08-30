FactoryGirl.define do
  factory :user do
    sequence(:first_name, 1) { |n| "John#{n}" }
    sequence(:last_name, 1)  { |n| "Doe#{n}" }
    sequence(:email,1)       { |n| "email#{n}@example.com" }
    password                 "P@ssw0rd!"
    password_confirmation    "P@ssw0rd!"
  end
end
