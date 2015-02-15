def create_project(name: 'deploymy-codes/api', remote_id: 25465783, user: nil)
  remote_project = Customers::RemoteProject.new(name: name, url: 'http://www.google.com', id: remote_id)

  Projects::Create.new(user, remote_project).run!
end
