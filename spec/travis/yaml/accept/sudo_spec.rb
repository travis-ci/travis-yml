describe Travis::Yaml, 'sudo' do
  let(:msgs) { subject.msgs }
  let(:sudo) { subject.to_h[:sudo] }

  subject { described_class.apply(config) }

  describe 'defaults to true' do
    let(:config) { {} }
    it { expect(sudo).to be false }
  end

  describe 'given true' do
    let(:config) { { sudo: true } }
    it { expect(sudo).to be true }
  end

  describe 'given false' do
    let(:config) { { sudo: false } }
    it { expect(sudo).to be false }
  end

  describe 'given required' do
    let(:config) { { sudo: 'required' } }
    it { expect(sudo).to be true }
  end
end
