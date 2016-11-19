describe Travis::Yaml, 'deploy gae' do
  let(:msgs)   { subject.msgs }
  let(:deploy) { subject.to_h[:deploy] }

  subject { described_class.apply(input) }

  let(:input) do
    {
      deploy: {
        provider: 'gae',
        project: 'project',
        keyfile: 'keyfile',
        config: 'config',
        version: 'version',
        no_promote: true,
        no_stop_previous_version: true,
        verbosity: 'verbosity',
      }
    }
  end

  it { expect(deploy).to eq [input[:deploy]] }
end
