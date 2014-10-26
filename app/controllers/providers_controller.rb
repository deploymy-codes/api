class ProvidersController < ApplicationController

  def index
    render json: Providers::List.call
  end

end
