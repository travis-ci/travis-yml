describe Travis::Yaml, 'deploy script' do
  let(:deploy) { subject.serialize[:deploy] }

  subject { described_class.apply(input) }

  let(:input) do
    {
      deploy: {
        provider: 'script',
        script: 'script',
      }
    }
  end

  it { expect(deploy).to eq [input[:deploy]] }
end
