describe Travis::Yaml do
  let(:config) { described_class.apply(input).serialize }
  let(:input)  { { language: 'clojure', jdk: ['default'], lein: 'lein1' } }

  it { expect(config[:language]).to eq 'clojure' }
  it { expect(config[:jdk]).to eq ['default'] }
  it { expect(config[:lein]).to eq 'lein1' }
end
