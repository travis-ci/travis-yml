describe Travis::Yml, 'format' do
  subject { described_class.apply(value) }

  describe 'version' do
    describe 'given a version' do
      let(:value) { { version: '~> 1.0.0' } }
      it { should_not have_msg }
    end

    describe 'given a non-version' do
      let(:value) { { version: 'foo' } }
      it { should have_msg [:error, :version, :invalid_format, format: '^(~>|>|>=|=|<=|<) (\d+(?:\.\d+)?(?:\.\d+)?)$', value: 'foo'] }
    end
  end
end
