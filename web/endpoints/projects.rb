require_relative "../helpers/user_helper"
require_relative "../helpers/project_helper"

require_relative './projects/list'
require_relative './projects/get'
require_relative './projects/list_environment'
require_relative './projects/create_environment'
require_relative './projects/get_environment'
require_relative './projects/list_deployment'
require_relative './projects/create_deployment'

require_relative './projects/list_branch'
require_relative './projects/list_tag'
require_relative './projects/list_commit'

module Endpoint
  class Projects < Web
    helpers UserHelper
    helpers ProjectHelper

    register List
    register Get
    register ListEnvironment
    register CreateEnvironment
    register GetEnvironment
    register ListDeployment
    register CreateDeployment

    register ListBranch
    register ListTag
    register ListCommit
  end
end
