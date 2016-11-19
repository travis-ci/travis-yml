describe Travis::Yaml::Doc::Change::Downcase do
  let(:lang)  { subject.raw[:language] }
  let(:value) { { language: 'RUBY' } }

  subject { change(build(nil, :root, value, {})) }

  it { expect(lang).to eq 'ruby' }
  it { expect(info).to include [:info, :language, :downcase, value: 'RUBY'] }
end
