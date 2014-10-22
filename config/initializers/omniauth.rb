Rails.application.config.middleware.use OmniAuth::Builder do
  provider :bitbucket, Rails.application.secrets.bitbucket_key, Rails.application.secrets.bitbucket_secret

  provider :github, Rails.application.secrets.github_key, Rails.application.secrets.github_secret, scope: 'user'
end
