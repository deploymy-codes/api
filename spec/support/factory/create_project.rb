def create_project(name: 'deploymy-codes/api', remote_id: 25465783, remote_url: 'https://github.com/deploymy-codes/api.git', user: nil)
  remote_project = Customers::RemoteProject.new(name: name, url: remote_url, id: remote_id)

  Projects::Create.new(user, remote_project).run!
end
