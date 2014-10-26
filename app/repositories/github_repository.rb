class GithubRepository

  def projects(account)
    client = Octokit::Client.new(access_token: account.token, auto_paginate: true)

    client.repositories
  end

end
