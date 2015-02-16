require 'spec_helper'

module Projects
  describe 'Find Project by name' do
    let(:user) { create_user }

    context 'When project is not found' do
      it 'raise a record not found error' do
        expect {
          FindByName.new(nil, nil, user).run!
        }.to raise_error ProjectRepository::UnknownNameError
      end
    end

    context 'When project is found' do
      let!(:project) { create_project user: user}

      it 'returns the project' do
        owner, repo = project.name.split '/'
        result_project = FindByName.new(owner, repo, user).run!

        expect(result_project.name).to be_eql project.name
      end
    end

  end
end
