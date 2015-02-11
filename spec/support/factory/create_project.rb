def create_project(name: 'rails', user: nil)
  remote_project = Customers::RemoteProject.new(name: 'rails', url: 'http://www.google.com')

  Projects::Create.new(user, remote_project).run!
end
