require 'sinatra'
require "sinatra/reloader"
require "sinatra/json"

class Web < Sinatra::Base
  helpers Sinatra::JSON

  configure :development do
    register Sinatra::Reloader
  end

end
