require 'sinatra'
require "sinatra/reloader"

class Web < Sinatra::Base

  configure :development do
    register Sinatra::Reloader
  end

end
