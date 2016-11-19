describe Travis::Yaml, 'deploy catalyze' do
  let(:msgs)   { subject.msgs }
  let(:deploy) { subject.to_h[:deploy] }

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
