describe Travis::Yaml::Doc::Value::Scalar do
  let(:value) { { language: 'ruby' } }
  let(:root)  { Travis::Yaml.build(value) }
  let(:lang)  { root[:language] }

  describe 'set' do
    before { lang.set('go') }
    it { expect(lang.raw).to eq 'go' }
  end

  describe 'drop' do
    before { lang.drop }
    it { expect(lang.raw).to be_nil }
  end
end
