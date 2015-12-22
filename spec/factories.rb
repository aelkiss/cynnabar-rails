FactoryGirl.define do

  factory :page do
    sequence(:slug) { |n| "slug#{n}" }
    title { "title for #{slug}" }
    body { "<h1>This is some html markup for #{slug}</h1>" }
  end

  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    role :normal
    password "password"

    trait :admin do
      role :admin
    end
  end

end
