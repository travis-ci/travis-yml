describe Travis::Yaml, 'deploy catalyze' do
  let(:deploy) { subject.serialize[:deploy] }

  subject { described_class.apply(input) }

  let(:input) do
    {
      deploy: {
        provider: 'catalyze',
        target: 'target',
        path: 'path',
      }
    }
  end

  it { expect(deploy).to eq [input[:deploy]] }
end
