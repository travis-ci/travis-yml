describe Travis::Yml, 'addon: firefox' do
  subject { described_class.load(yaml) }

  describe 'given a num' do
    yaml %(
      addons:
        firefox: 15
    )
    it { should serialize_to addons: { firefox: 15 } }
    it { should_not have_msg }
  end

  describe 'given a str' do
    yaml %(
      addons:
        firefox: '15'
    )
    it { should serialize_to addons: { firefox: 15 } }
    it { should_not have_msg }
  end
end
