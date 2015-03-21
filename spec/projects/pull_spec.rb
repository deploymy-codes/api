require 'spec_helper'

module Projects
  describe 'Find Project by name' do
    let(:user) { create_user }
    let(:project) { create_project user: user }

    it 'pulls the project' do
      expect(GitService).to receive(:pull).with(project.dir, project.name)
      Pull.new(RepositoryForm.new(id: project.remote_id)).run!
    end
  end
end
