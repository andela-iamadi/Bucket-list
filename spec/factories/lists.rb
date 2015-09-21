FactoryGirl.define do
  factory :list do
    full_name "Joe Doe"
    email { "#{full_name.gsub(" ", "_")}@example.com".downcase }

    trait :is_admin do
      role :admin
    end
  end
end
