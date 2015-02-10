require 'spec_helper'

module Projects
  describe 'Find Project' do
    let(:user) { create_user }

    context 'When project is not found' do
      it 'raise a record not found error' do
        expect {
          Find.new(nil, user).run!
        }.to raise_error ProjectRepository::UnknownNameError
      end
    end

    context 'When project is found' do
      let!(:project) { create_project name: 'rails', user: user}

      it 'returns the project' do
        result_project = Find.new('rails', user).run!

        expect(result_project.name).to be_eql 'rails'
      end
    end

  end
end
