describe Travis::Yaml, 'addons' do
  let(:addons) { subject.serialize[:addons] }

  subject { described_class.apply(input) }

  describe 'drops an unknown addon' do
    let(:input) { { addons: { unknown: { foo: 'bar' } } } }
    it { expect(addons).to be_nil }
    it { expect(msgs).to include [:error, :addons, :unknown_key, key: :unknown, value: { foo: 'bar' }] }
  end

  describe 'given a nested, misplaced hash (1)' do
    let(:input) { { addons: { sauce_connect: { sauce_connect: true } } } }
    it { expect(addons[:sauce_connect]).to eq enabled: true }
    it { expect(msgs).to include [:warn, :'addons.sauce_connect', :migrate, key: :sauce_connect, to: :addons, value: true] }
  end

  describe 'given a nested, misplaced hash (2)' do
    let(:input) { { addons: { sauce_connect: true, addons: { hosts: 'localhost' } } } }
    it { expect(addons).to eq sauce_connect: { enabled: true }, hosts: ['localhost'] }
    it { expect(msgs).to include [:warn, :addons, :migrate, key: :addons, to: :root, value: { hosts: 'localhost' }] }
  end

  describe 'given an array with a hash with a misplaced key with a nested, misplaced key' do
    let(:input) { { addons: [coverity_scan: nil, project: { name: 'name', build_command: 'cmd' }] } }
    it { expect(addons).to eq coverity_scan: { project: { name: 'name' }, build_command: 'cmd' } }
    it { expect(msgs).to include [:warn, :addons, :invalid_seq, value: input[:addons][0]] }
    it { expect(msgs).to include [:warn, :addons, :migrate, key: :project, to: :coverity_scan, value: { name: 'name', build_command: 'cmd' }] }
    it { expect(msgs).to include [:warn, :'addons.coverity_scan.project', :migrate, key: :build_command, to: :coverity_scan, value: 'cmd'] }
  end
end
