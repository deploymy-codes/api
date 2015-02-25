ENV['RACK_ENV'] = 'test'
require_relative './../dmc'
require 'rack/test'
require 'vcr'

Dir["./spec/support/**/*.rb"].sort.each { |f| require f}

RSpec.configure do |config|
  include Rack::Test::Methods
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before(:each) do
    Customers::UserRepository.clear
    Customers::AccountRepository.clear
    Projects::ProjectRepository.clear
    Environments::EnvironmentRepository.clear
    Deployments::DeploymentRepository.clear
  end

  config.after(:each) do
    dirs = Dir.glob "#{DMC.root}/../tmp/*"
    FileUtils.rm_rf dirs
  end
end

VCR.configure do |c|
  c.hook_into :webmock
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'

  c.filter_sensitive_data('GITHUB_CLIENT_SECRET') { ENV['OCTOKIT_CLIENT_SECRET'] }
  c.filter_sensitive_data('GITHUB_CLIENT_ID')     { ENV['OCTOKIT_CLIENT_ID'] }
  c.filter_sensitive_data('GITHUB_OAUTH_TOKEN')   { ENV['GITHUB_OAUTH_TOKEN'] }

  c.filter_sensitive_data('HEROKU_API_KEY')  { ENV['HEROKU_API_KEY'] }
  c.filter_sensitive_data('HEROKU_APP_NAME') { ENV['HEROKU_APP_NAME'] }

  c.around_http_request do |request|
    VCR.use_cassette(get_cassette_path(request), match_requests_on: [:method, :body], &request)
  end
end

def get_cassette_path(request)
  if request.uri =~ /api\.github.*applications.*tokens/
    "github/revoke_token"
  elsif request.uri =~ /github\.com/
    path = request.uri.gsub('https://', '').gsub('/', '_')
    "github/#{path}"
  else
    raise "Unknown external url:#{request.uri}, please fix method get_cassette_path"
  end
end
