require 'spec_helper'

module Deploy
  describe 'Find Project' do
    let(:user) { create_user }

    context 'When project is not found' do
      it 'raise a record not found error' do
        expect {
          FindProject.new(nil, user).run!
        }.to raise_error ProjectRepository::UnknownProjectNameError
      end
    end

    context 'When project is found' do
      let!(:project) { create_project name: 'rails', user: user}

      it 'returns the project' do
        result_project = FindProject.new('rails', user).run!

        expect(result_project.name).to be_eql 'rails'
      end
    end

  end
end
