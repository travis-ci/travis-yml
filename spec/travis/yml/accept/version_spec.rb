describe Travis::Yml do
  accept 'version' do
    describe 'a valid version' do
      yaml %(
        version: ~> 1.0.1
      )
      it { Travis::Yml.schema }
      it { should serialize_to version: '~> 1.0.1' }
      it { should_not have_msg }
    end

    describe 'an invalid version', drop: true do
      yaml %(
        version: not-a-version
      )
      it { should serialize_to empty }
      it { should have_msg [:error, :version, :invalid_format, value: 'not-a-version', format: '^(~>|>|>=|=|<=|<) (\d+(?:\.\d+)?(?:\.\d+)?)$'] }
    end
  end
end
