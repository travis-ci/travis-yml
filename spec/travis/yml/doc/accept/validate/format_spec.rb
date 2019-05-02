describe Travis::Yml, 'format', line: true do
  subject { described_class.apply(parse(yaml), opts) }

  describe 'version' do
    describe 'given a version' do
      yaml 'version: ~> 1.0.0'
      it { should_not have_msg }
    end

    describe 'given a non-version' do
      yaml 'version: foo'
      it { should have_msg [:error, :version, :invalid_format, format: '^(~>|>|>=|=|<=|<) (\d+(?:\.\d+)?(?:\.\d+)?)$', value: 'foo', line: 0] }
    end
  end
end
