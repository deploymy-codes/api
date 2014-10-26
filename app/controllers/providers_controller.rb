class ProvidersController < ApplicationController

  def index
    Providers::List.call
  end

end
