class ProvidersController

  def index
    Providers::List.call
  end

end
