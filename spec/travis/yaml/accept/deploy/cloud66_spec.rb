describe Travis::Yaml, 'deploy cloud66' do
  let(:msgs)   { subject.msgs }
  let(:deploy) { subject.to_h[:deploy] }

  subject { described_class.apply(input) }

  let(:input) do
    {
      deploy: {
        provider: 'cloud66',
        redeployment_hook: 'redeployment_hook',
      }
    }
  end

  it { expect(deploy).to eq [input[:deploy]] }
end
