describe Travis::Yaml, 'version' do
  let(:config) { subject.serialize }
  let(:opts)   { {} }

  subject { described_class.apply(input, opts) }

  describe 'given a string' do
    let(:input) { { version: '~> 1.0.1' } }
    it { expect(config[:version]).to eq '~> 1.0.1' }
  end
end
