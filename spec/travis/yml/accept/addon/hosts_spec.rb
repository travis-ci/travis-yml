describe Travis::Yml, 'addon: hosts' do
  subject { described_class.load(yaml) }

  describe 'given a string' do
    yaml %(
      addons:
        hosts: foo.dev
    )
    it { should serialize_to addons: { hosts: ['foo.dev'] } }
    it { should_not have_msg }
  end

  describe 'given an array' do
    yaml %(
      addons:
        hosts:
        - foo.dev
        - bar.dev
    )
    it { should serialize_to addons: { hosts: ['foo.dev', 'bar.dev'] } }
    it { should_not have_msg }
  end
end
