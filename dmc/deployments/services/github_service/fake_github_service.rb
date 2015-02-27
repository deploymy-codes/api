module Deployments
  class FakeGithubService
    FakeRelease = Struct.new :tarball_url

    def create_release(_, _, _, _)
      FakeRelease.new tarball_url: 'http://www.google.com'
    end

  end
end
