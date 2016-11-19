describe Travis::Yaml, 'sudo' do
  let(:sudo) { subject.serialize[:sudo] }

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

  describe 'given enabled' do
    let(:config) { { sudo: 'enabled' } }
    it { expect(sudo).to be true }
    it { expect(info).to include [:info, :sudo, :cast, given_value: 'enabled', given_type: :str, value: true, type: :bool] }
  end
end
