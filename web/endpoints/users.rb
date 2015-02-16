require_relative "../helpers/user_helper"

module Endpoint
  class Users < Web
    helpers UserHelper

    get '/self' do
      json serialize(current_user)
    end

    get '/remote_projects' do
      use_case = Customers::ListRemoteProject.new current_user, pager
      remote_projects = use_case.run!

      json serialize(remote_projects)
    end

    post '/remote_projects/:owner/:repo/import' do |owner, repo|
      use_case = Customers::GetRemoteProject.new current_user, owner, repo
      remote_project = use_case.run!

      use_case = ::Projects::Create.new current_user, remote_project
      project = use_case.run!
      status 201
      json serialize(project)
    end

    error ::Projects::NameTakenError do
      halt_json_error 403
    end
  end
end
