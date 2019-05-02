describe Travis::Yml, 'unknown_value', line: true do
  subject { described_class.apply(parse(yaml), opts) }

  describe 'given a known value' do
    yaml 'git: { strategy: clone }'
    it { should serialize_to git: { strategy: 'clone' } }
    it { should_not have_msg }
  end

  describe 'given an unknown value' do
    yaml 'git: { strategy: unknown }'
    it { should serialize_to empty }
    it { should have_msg [:error, :'git.strategy', :unknown_value, value: 'unknown', line: 0] }
  end
end
