module ProjectHelper
  def current_project
    @current_project ||= Projects::FindProject.new(params[:project_name], current_user).run!
  end
end
