root = File.dirname __FILE__

require "#{root}/../app/dmc"
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
