# frozen_string_literal: true
FactoryGirl.define do
  factory :office do
    sequence(:email) { |n| "office#{n}@example.com" }
    sequence(:name) { |n| "Office #{n}" }
    sequence(:image) { |n| "/images/office#{n}.png" }
    association :page
  end

  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    role :normal
    password 'password'
    name 'Bob Exampleman'
    approved true

    trait :admin do
      role :admin
    end

    trait :herald do
      role :herald
    end

    trait :has_recipient do
      association :recipient
    end
  end

  factory :page do
    sequence(:slug) { |n| "slug#{n}" }
    title { "title for #{slug}" }
    body { "<h1>This is some html markup for #{slug}</h1>" }
    association :user, :admin

    trait :calendar do
      calendar 'example'
      calendar_title 'Example Events'
      body { "<h1>Some sample markup for #{slug}</h1><!-- CALENDAR -->" }
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

    trait :text do
      award_text 'Some long and wordy text for the award.'
    end
  end

  factory :award do
    name 'test award'
    precedence 0
    description 'this is a long description of what the test award is'
    society false

    trait :hasgroup do
      association :group
    end

    trait :other do
      other_award true
    end

    trait :society do
      society true
    end

    trait :heraldry do
      heraldry { File.new("#{Rails.root}/spec/assets/heraldry.gif") }
    end
  end

  factory :recipient do
    mundane_name 'mundane name'

    trait :sca do
      sca_name 'sca name'
    end

    trait :group do
      mundane_name nil
      sca_name 'group name'
      is_group true
    end

    trait :othernames do
      also_known_as 'bob smith'
      formerly_known_as 'carol jones'
    end

    trait :pronouns do
      pronouns 'They/them/their'
    end

    trait :heraldry do
      heraldry { File.new("#{Rails.root}/spec/assets/heraldry.gif") }
    end
  end

  factory :group do
    name 'group name'
  end
end
