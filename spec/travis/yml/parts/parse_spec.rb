describe Travis::Yml::Parts::Parse do
  let(:part) { Travis::Yml::Parts::Part.new(str, '.travis.yml') }
  let(:json) { '{ "script": "./str" }' }
  let(:yaml) { 'script: ./str' }

  subject { described_class.new(part).apply }

  describe 'given yaml' do
    let(:str) { yaml }
    it { should eq 'script' => './str' }
    it { expect(subject.keys.first.src).to eq '.travis.yml' }
  end

  describe 'given json' do
    let(:str) { json }
    it { should eq 'script' => './str' }
    it { expect(subject.keys.first.src).to eq '.travis.yml' }
  end
end
