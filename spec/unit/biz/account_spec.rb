require 'spec_helper'

RSpec.describe Biz::Account do

  let(:biz) { double 'biz' }

  before do
    biz.extend Biz::Account
  end

  describe '#is?' do
    subject { biz.is? provider }

    let(:provider) { 'provider' }

    context 'when provider is equal to biz provider' do
      before do
        expect(biz).to receive(:provider).and_return provider
      end

      it { should be true }
    end

    context 'when provider is different to biz provider' do
      before do
        expect(biz).to receive(:provider).and_return 'different'
      end

      it { should be false }
    end
  end

end
