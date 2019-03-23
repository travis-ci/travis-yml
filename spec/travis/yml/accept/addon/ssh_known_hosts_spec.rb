describe Travis::Yml, 'addon: ssh_known_hosts' do
  subject { described_class.apply(parse(yaml)) }

  describe 'given a string' do
    yaml %(
      addons:
        ssh_known_hosts: git.foo.org
    )
    it { should serialize_to addons: { ssh_known_hosts: ['git.foo.org'] } }
    it { should_not have_msg }
  end

  describe 'given an array' do
    yaml %(
      addons:
        ssh_known_hosts:
        - git.foo.org
        - git.foo.com
    )
    it { should serialize_to addons: { ssh_known_hosts: ['git.foo.org', 'git.foo.com'] } }
    it { should_not have_msg }
  end
end
