class ProviderRepository

  def all
    [Github.new, Bitbucket.new]
  end

end
