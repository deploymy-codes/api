root = File.dirname __FILE__

require "#{root}/../dmc"
require "#{root}/lib/web"

map '/auth' do
  require "#{root}/endpoints/auth"
  run Endpoint::Auth
end

map '/projects' do
  require "#{root}/endpoints/webhook"
  run Endpoint::Webhook
end

map '/users' do
  require "#{root}/endpoints/users"
  run Endpoint::Users
end

map '/projects' do
  require "#{root}/endpoints/projects"
  run Endpoint::Projects
end

map '/streams' do
  require "#{root}/endpoints/streams"
  run Endpoint::Streams
end
