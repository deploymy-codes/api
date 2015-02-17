module ProjectHelper
  def current_project
    @current_project ||= Projects::FindByName.new(params[:owner], params[:repo], current_user).run!
  end

  def current_environment
    @current_environment ||= Environments::FindByName.new(params[:environment_name], current_project).run!
  end
end
