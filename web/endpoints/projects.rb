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

    get '/:project_name/environments/:environment_name' do |_, _|
      json serialize(current_environment)
    end

    get '/:project_name/environments/:environment_name/deployments' do |_, environment_name|
      use_case     = Deployments::List.new current_environment
      deployments  = use_case.run!

      json serialize(deployments)
    end

    post '/:project_name/environments/:environment_name/deployments' do |project_name, environment_name|
      form     = Deployments::CreateForm.new extract!(:deployment)
      use_case = Deployments::Create.new current_environment, form

      deployment = use_case.run!

      json serialize(deployment)
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
