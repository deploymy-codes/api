module Customer
  class GetRemoteProject < Struct.new(:user, :name)

    def run!
      remote_projects = Customer::ListRemoteProject.new(user).run!
      remote_project  = remote_projects.find { |element| element.name == name }

      raise RemoteProjectNotFound, name unless remote_project

      remote_project
    end

  end
end
