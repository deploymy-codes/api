module ProjectHelper
  def current_project
    Deploy::FindProject.new(params[:project_name], current_user).run!
  end
end
