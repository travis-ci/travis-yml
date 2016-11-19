describe Travis::Yaml, 'addon: coverity_scan' do
  let(:msgs)   { subject.msgs }
  let(:addons) { subject.serialize[:addons] }

  subject { described_class.apply(config.merge(language: 'ruby')) }

  describe 'coverity_scan' do
    config = {
      project: { name: 'foo' },
      build_script_url:      'url',
      branch_pattern:        'pattern',
      notification_email:    'email',
      build_command:         'cmd',
      build_command_prepend: 'prefix'
    }

    let(:config) { { addons: { coverity_scan: config } } }

    it { expect(addons[:coverity_scan][:project]).to               eq(name: 'foo') }
    it { expect(addons[:coverity_scan][:build_script_url]).to      eq 'url' }
    it { expect(addons[:coverity_scan][:branch_pattern]).to        eq 'pattern' }
    it { expect(addons[:coverity_scan][:notification_email]).to    eq 'email' }
    it { expect(addons[:coverity_scan][:build_command]).to         eq 'cmd' }
    it { expect(addons[:coverity_scan][:build_command_prepend]).to eq 'prefix' }
  end
end
