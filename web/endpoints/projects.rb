require_relative "../helpers/user_helper"

class Projects < Web
  helpers UserHelper

  get '/' do
    use_case = Deploy::ListProject.new current_user
    projects = use_case.run!

    json serialize(projects)
  end

  get '/:name' do

  end
end
