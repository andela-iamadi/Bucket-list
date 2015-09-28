
FactoryGirl.define do
  factory :user do
    full_name "John Doe"
    email { "#{full_name.gsub(" ", "_")}@example.com".downcase }
    password "password"
    password_confirmation "password"

    trait :is_admin do
      role :admin
    end
  end
end
