module Projects
  class Clone < Struct.new(:project)

    def run!
      account = Customers::GetAccount.new('github', project.user_id).run!

      GitService.clone project.dir, project.url, account.oauth_token
    end

  end
end
