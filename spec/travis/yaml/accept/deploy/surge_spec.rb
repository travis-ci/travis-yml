describe Travis::Yaml, 'deploy surge' do
  let(:deploy) { subject.serialize[:deploy] }

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
