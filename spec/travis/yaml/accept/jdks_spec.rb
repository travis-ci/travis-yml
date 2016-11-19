describe Travis::Yaml do
  let(:msgs)  { subject.msgs }
  let(:value) { subject.to_h }

  subject { described_class.apply(input) }

  describe 'on linux, ruby, jruby' do
    let(:input) { { sudo: false, language: 'ruby', ruby: ['jruby'], jdk: ['7'] } }

    it { expect(value[:jdk]).to eq ['7'] }
    it { expect(msgs).to be_empty }
  end

  describe 'on linux, ruby, mri' do
    let(:input) { { sudo: false, language: 'ruby', ruby: ['2.3.0'], jdk: ['7'] } }

    xit { expect(value[:jdk]).to be_nil }
    xit { expect(msgs).to include [] }
  end

  describe 'on osx' do
    let(:input) { { sudo: false, language: 'ruby', os: 'osx', ruby: ['jruby'], jdk: ['7'] } }

    it { expect(value[:jdk]).to be_nil }
    it { expect(msgs).to include [:error, :jdk, :unsupported, 'jdk (["7"]) is not supported on os "osx"'] }
  end

  describe 'on osx (alias mac)' do
    let(:input) { { sudo: false, language: 'ruby', os: 'mac', ruby: ['jruby'], jdk: ['7'] } }

    it { expect(value[:jdk]).to be_nil }
    it { expect(msgs).to include [:error, :jdk, :unsupported, 'jdk (["7"]) is not supported on os "osx"'] }
  end
end
