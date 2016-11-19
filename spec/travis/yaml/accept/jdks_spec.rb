describe Travis::Yaml do
  let(:value) { subject.serialize }

  subject { described_class.apply(input) }

  describe 'on linux, ruby, jruby' do
    let(:input) { { language: 'ruby', rvm: ['jruby'], jdk: ['default'] } }

    it { expect(value[:jdk]).to eq ['default'] }
    it { expect(msgs).to be_empty }
  end

  describe 'on osx' do
    let(:input) { { language: 'ruby', os: 'osx', rvm: ['jruby'], jdk: ['default'] } }

    it { expect(value[:jdk]).to be_nil }
    it { expect(msgs).to include [:error, :jdk, :unsupported, on_key: :os, on_value: 'osx', key: :jdk, value: ['default']] }
  end

  describe 'on osx (alias mac)' do
    let(:input) { { language: 'ruby', os: 'mac', rvm: ['jruby'], jdk: ['default'] } }

    it { expect(value[:jdk]).to be_nil }
    it { expect(msgs).to include [:error, :jdk, :unsupported, on_key: :os, on_value: 'osx', key: :jdk, value: ['default']] }
  end

  describe 'on multios' do
    let(:input) { { language: 'ruby', os: ['linux', 'osx'], jdk: ['default'] } }

    it { expect(value[:jdk]).to eq ['default'] }
    it { expect(msgs).to be_empty }
  end
end
