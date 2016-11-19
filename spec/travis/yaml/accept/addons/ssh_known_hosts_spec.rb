describe Travis::Yaml, 'addon: ssh_known_hosts' do
  let(:msgs)   { subject.msgs }
  let(:addons) { subject.to_h[:addons] }

  subject { described_class.apply(config.merge(language: 'ruby')) }

  describe 'ssh_known_hosts' do
    describe 'given a string' do
      let(:config) { { addons: { ssh_known_hosts: 'git.foo.org' } } }
      it { expect(addons[:ssh_known_hosts]).to eq ['git.foo.org'] }
    end

    describe 'given an array' do
      let(:config) { { addons: { ssh_known_hosts: ['git.foo.org', 'git.foo.com'] } } }
      it { expect(addons[:ssh_known_hosts]).to eq ['git.foo.org', 'git.foo.com'] }
    end
  end
end
