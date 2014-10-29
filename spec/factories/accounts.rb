FactoryGirl.define do
  factory :account do
    oauth_token 'token'

    trait :github do
      provider 'github'
    end

    trait :bitbucket do
      provider 'bitbucket'
    end
  end
end
