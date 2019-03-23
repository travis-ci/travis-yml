describe Travis::Yaml do
  let(:input)  { { language: 'ruby', rvm: '2.3', gemfile: 'Gemfile', jdk: ['default'], bundler_args: 'args' } }
  let(:config) { subject.serialize }
  let(:lang)   { config[:language] }

  subject { described_class.apply(input) }

  it { expect(config[:language]).to eq 'ruby' }
  it { expect(config[:rvm]).to eq ['2.3'] }
  it { expect(config[:gemfile]).to eq ['Gemfile'] }
  it { expect(config[:jdk]).to eq ['default'] }
  it { expect(config[:bundler_args]).to eq 'args' }

  describe 'downcase' do
    let(:input) { { language: 'Ruby' } }
    it { expect(lang).to eq 'ruby' }
    it { expect(info).to include [:info, :language, :downcase, value: 'Ruby'] }
  end

  describe 'gemfiles (alias)' do
    let(:input) { { gemfiles: 'Gemfile' } }
    it { expect(config[:gemfile]).to eq ['Gemfile'] }
  end
end
