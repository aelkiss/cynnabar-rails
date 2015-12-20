FactoryGirl.define do
  factory :page do
    slug { ('a'..'z').to_a.shuffle[0,8].join }
    title { "title for #{slug}" }
    body { "<h1>This is some html markup for #{slug}</h1>" }
  end
end
