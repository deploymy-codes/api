FactoryGirl.define do
  factory :account do
    oauth_token { Forgery(:lorem_ipsum).words(1) }

    trait :github do
      provider 'github'
    end

    trait :bitbucket do
      provider 'bitbucket'
    end
  end
end
