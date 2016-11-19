describe Travis::Yaml::Doc::Factory::Node do
  let(:spec) { { type: :fixed } }

  subject { described_class.new(spec, nil, :key, true).build }

  describe 'builds a node' do
    it { should be_a Travis::Yaml::Doc::Type::Fixed }
  end

  describe 'passes known options' do
    let(:spec) { { type: :fixed, known: true } }
    it { should be_known }
  end

  describe 'does not pass unknown options' do
    let(:spec) { { type: :fixed, foo: true } }
    it { expect(subject.opts).to_not be_key(:foo) }
  end

  describe 'calls normalizers' do
    let(:spec) { { type: :fixed, normalize: [name: :enabled] } }
    it { expect(subject.value).to eq enabled: true }
  end

  describe 'calls normalizers in the right order' do
    let(:spec)     { { type: :fixed, normalize: [name: :enabled] } }
    let(:keys)     { [:symbolize, :secure, :enabled, :prefix] }
    let(:registry) { Travis::Yaml::Doc::Normalize::Normalizer }

    before { allow(registry).to receive(:[]).and_call_original }
    before { subject }

    it { keys.each { |key| expect(registry).to have_received(:[]).with(key).ordered } }
  end
end
