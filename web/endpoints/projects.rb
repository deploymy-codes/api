require_relative "../helpers/user_helper"
require_relative "../helpers/project_helper"

module Endpoint
  class Projects < Web
    helpers UserHelper
    helpers ProjectHelper

    get '/' do
      use_case = ::Projects::List.new current_user
      projects = use_case.run!

      json serialize(projects)
    end

    get '/:project_name' do |project_name|
      json serialize(current_project)
    end

    get '/:project_name/environments' do |project_name|
      use_case     = Environments::List.new current_project
      environments = use_case.run!

      json serialize(environments)
    end

    post '/:project_name/environments' do |project_name|
      form         = Environments::CreateForm.new extract!(:environment)
      use_case     = Environments::Create.new current_project, form
      environment  = use_case.run!

      json serialize(environment)
    end

    post '/:project_name/environments/:environment_name' do |project_name, environment_name|
      use_case    = Environments::Find.new environment_name, project
      environment = use_case.run!

      json serialize(environment)
    end

    error Environments::EnvironmentRepository::UnknownNameError do
      halt_json_error 404
    end

    error ::Projects::ProjectRepository::UnknownNameError do
      halt_json_error 404
    end

    error Environments::NameTakenError do
      halt_json_error 403
    end

  end
end
