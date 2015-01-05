def create_project(name: 'rails', user: nil)
  remote_project = Customer::RemoteProject.new(name: 'rails', url: 'http://www.google.com')

  Deploy::CreateProject.new(user, remote_project).run!
end
