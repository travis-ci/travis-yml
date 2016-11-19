describe Travis::Yaml::Doc::Normalize::Enabled do
  let(:result) { described_class.new(nil, {}, :key, value).apply }

  describe 'given true' do
    let(:value) { true }
    it { expect(result).to eq enabled: true }
  end

  describe 'given false' do
    let(:value) { false }
    it { expect(result).to eq enabled: false }
  end

  describe 'given an empty hash' do
    let(:value) { {} }
    it { expect(result).to eq enabled: false }
  end

  describe 'given a non-empty hash without an :enabled key' do
    let(:value) { { foo: :foo } }
    it { expect(result).to eq enabled: true, foo: :foo }
  end

  describe 'given a hash with enabled: true' do
    let(:value) { { enabled: true } }
    it { expect(result).to eq enabled: true }
  end

  describe 'given a hash with enabled: false' do
    let(:value) { { enabled: false } }
    it { expect(result).to eq enabled: false }
  end

  describe 'given a hash with disabled: true' do
    let(:value) { { disabled: true } }
    it { expect(result).to eq enabled: false }
  end

  describe 'given a hash with disabled: false' do
    let(:value) { { disabled: false } }
    it { expect(result).to eq enabled: true }
  end
end
