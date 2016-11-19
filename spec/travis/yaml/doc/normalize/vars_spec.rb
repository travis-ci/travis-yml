describe Travis::Yaml::Doc::Normalize::Vars do
  let(:result) { described_class.new(nil, {}, :key, value).apply }

  describe 'given an array of strings' do
    let(:value) { ['FOO=foo'] }
    it { expect(result).to eq ['FOO=foo'] }
  end

  describe 'given a hash' do
    let(:value) { { FOO: 'foo' } }
    it { expect(result).to eq ['FOO=foo'] }
  end
end
