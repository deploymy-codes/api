require 'rails_helper'

RSpec.describe ActiveRecordRepository do

  describe '#build' do
    it 'build the specific model with attributes' do
      user = subject.build :user, email: 'foo@bar.com'

      expect(user).to be_instance_of User
      expect(user.email).to be_eql 'foo@bar.com'
    end
  end

  describe '#find_by' do
    it 'retrieves the model according to the attributes' do
      user   = create(:user)
      result = subject.find_by :user, email: user.email

      expect(result).to be_eql user
    end
  end

  describe '#save' do
    it 'saves the model' do
      user = build(:user)
      subject.save(user)

      expect(user.persisted?).to be true
    end
  end

  describe '#update_attributes_of' do
    it 'updates the model with attributes' do
      user   = create(:user)
      subject.update_attributes_of user, email: 'foo@bar.com'

      expect(user.email).to be_eql 'foo@bar.com'
    end
  end

end
