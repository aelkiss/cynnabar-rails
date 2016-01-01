FactoryGirl.define do  
  factory :office do
    sequence(:email) { |n| "office#{n}@example.com" }
    sequence(:name) { |n| "Office #{n}" }
    sequence(:image) { |n| "/images/office#{n}.png" }
  end

  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    role :normal
    password "password"

    trait :admin do
      role :admin
    end
  end

  factory :page do
    sequence(:slug) { |n| "slug#{n}" }
    title { "title for #{slug}" }
    body { "<h1>This is some html markup for #{slug}</h1>" }
    association :user, :admin

    trait :office_page do
      association :office
    end
  end

  factory :awarding do
    association :award, :hasgroup
    association :recipient

    trait :other do
      association :award, :other
      association :group
      award_name 'other award name'
    end
  end

  factory :award do
    name "test award"
    precedence 0
    description "this is a long description of what the test award is"

    trait :hasgroup do
      association :group
    end

    trait :other do
      other_award true
    end
  end

  factory :recipient do
    mundane_name 'mundane name'

    trait :sca do
      sca_name 'sca name'
    end

    trait :group do
      sca_name 'group name'
      is_group true
    end

    trait :othernames do
      also_known_as 'bob smith'
      formerly_known_as 'carol jones'
    end
  end

  factory :group do
    name "group name"
  end


end
