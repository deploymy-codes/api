require_relative "../helpers/user_helper"
require_relative "../helpers/project_helper"

module Endpoint
  class Projects < Web
    helpers UserHelper
    helpers ProjectHelper

    get '/' do
      use_case = ::Projects::ListProject.new current_user
      projects = use_case.run!

      json serialize(projects)
    end

    get '/:project_name' do |project_name|
      json serialize(current_project)
    end

    get '/:project_name/environments' do |project_name|
      use_case     = Environments::ListEnvironment.new current_project
      environments = use_case.run!

      json serialize(environments)
    end

    post '/:project_name/environments' do |project_name|
      form         = Environments::EnvironmentForm.new extract!(:environment)
      use_case     = Environments::CreateEnvironment.new current_project, form
      environment  = use_case.run!

      json serialize(environment)
    end

    post '/:project_name/environments/:environment_name' do |project_name, environment_name|
      use_case    = Environments::FindEnvironment.new environment_name, project
      environment = use_case.run!

      json serialize(environment)
    end

    error Environments::EnvironmentRepository::UnknownEnvironmentNameError do
      halt_json_error 404
    end

    error ::Projects::ProjectRepository::UnknownProjectNameError do
      halt_json_error 404
    end

    error Environments::EnvironmentNameTakenError do
      halt_json_error 403
    end

  end
end
