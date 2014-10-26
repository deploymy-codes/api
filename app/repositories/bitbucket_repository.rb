class BitbucketRepository

  def project(account)
    bitbucket = BitBucket.new

    bitbucket.repos.list
  end

end
