require_relative "../helpers/user_helper"
require_relative "../helpers/project_helper"

class Projects < Web
  helpers UserHelper
  helpers ProjectHelper

  get '/' do
    use_case = Deploy::ListProject.new current_user
    projects = use_case.run!

    json serialize(projects)
  end

  get '/:project_name' do |project_name|
    json serialize(current_project)
  end

  get '/:project_name/environments' do |project_name|
    use_case     = Deploy::ListEnvironment.new current_project
    environments = use_case.run!

    json serialize(environments)
  end

  error Deploy::ProjectRepository::UnknownProjectNameError do
    halt_json_error 404
  end
end
