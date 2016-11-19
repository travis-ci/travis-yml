describe Travis::Yaml, 'deploy surge' do
  let(:msgs)   { subject.msgs }
  let(:deploy) { subject.to_h[:deploy] }

  subject { described_class.apply(input) }

  let(:input) do
    {
      deploy: {
        provider: 'surge',
        project: 'project',
        domain: 'domain',
      }
    }
  end

  it { expect(deploy).to eq [input[:deploy]] }
end
