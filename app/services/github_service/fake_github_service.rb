class FakeGithubService
  FakeUser = Struct.new(:name, :email)

  def fetch_token(code)
    'github-token'
  end

  def user(oauth_token)
    FakeUser.new('Aaron Patterson', 'aaron@tenderlove.org')
  end

end
