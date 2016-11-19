describe Travis::Yaml, 'addons' do
  let(:msgs)   { subject.msgs }
  let(:addons) { subject.to_h[:addons] }

  subject { described_class.apply(config.merge(language: 'ruby')) }

  describe 'drops an unknown addon' do
    let(:config) { { addons: { unknown: { foo: 'bar' } } } }
    it { expect(addons).to be_nil }
    it { expect(msgs).to include [:error, :addons, :unknown_key, 'dropping unknown key :unknown ({:foo=>"bar"})'] }
  end
end
