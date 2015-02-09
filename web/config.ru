root = File.dirname __FILE__

require "#{root}/../dmc/dmc"
require "#{root}/lib/web"

map '/auth' do
  require "#{root}/endpoints/auth"
  run Auth
end

map '/users' do
  require "#{root}/endpoints/users"
  run Users
end

map '/projects' do
  require "#{root}/endpoints/projects"
  run Projects
end

map '/streams' do
  require "#{root}/endpoints/streams"
  run Streams
end
