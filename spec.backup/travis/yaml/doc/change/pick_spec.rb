describe Travis::Yaml::Doc::Change::Pick do
  let(:addons) { subject.raw[:addons] }
  let(:lang)   { subject.raw[:language] }

  subject { change(build(nil, :root, value, {})) }

  describe 'wants a scalar' do
    let(:value) { { language: ['ruby'] } }
    it { expect(lang).to eq 'ruby' }
    it { expect(msgs).to include [:warn, :language, :invalid_seq, value: 'ruby'] }
  end

  describe 'wants a map' do
    let(:value) { { addons: [{ bundler: true }] } }
    it { expect(addons).to eq bundler: true }
    it { expect(msgs).to include [:warn, :addons, :invalid_seq, value: { bundler: true }] }
  end
end
