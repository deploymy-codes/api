class ProvidersController < ApplicationController

  def index
    render json: Providers::List.call
  end

  def show
    render json: Providers::Show.call(name: params[:id])
  end

end
