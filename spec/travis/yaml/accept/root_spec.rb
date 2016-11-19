describe Travis::Yaml, 'root' do
  let(:info)  { subject.msgs.select { |msg| msg[0] == :info } }
  let(:msgs)  { subject.msgs.select { |msg| msg[0] != :info } }
  let(:value) { subject.to_h }
  let(:opts)  { {} }

  subject { described_class.apply(input, opts) }

  describe 'default' do
    let(:input) { {} }
    it { expect(value).to eq(language: 'ruby', os: ['linux'], dist: 'precise', sudo: false) }
    it { expect(info).to include [:info, :language, :default, 'missing :language, defaulting to "ruby"'] }
  end

  describe 'given a non-hash' do
    let(:input) { 'foo' }
    it { expect(value).to be_nil }
  end

  describe 'drops an unknown key' do
    let(:input) { { foo: 'bar' } }
    it { expect(value[:foo]).to be_nil }
    it { expect(msgs).to include [:error, :root, :unknown_key, 'dropping unknown key :foo ("bar")'] }
  end

  describe 'sudo' do
    describe 'given true' do
      let(:input) { { sudo: true } }
      it { expect(value[:sudo]).to eq true }
    end

    describe 'given false' do
      let(:input) { { sudo: false } }
      it { expect(value[:sudo]).to eq false }
    end

    describe 'given a string' do
      let(:input) { { sudo: 'required' } }
      it { expect(value[:sudo]).to eq true }
    end

    describe 'given an integer' do
      let(:input) { { sudo: 1 } }
      it { expect(value[:sudo]).to eq true }
    end
  end

  describe 'osx_image' do
    let(:input) { { osx_image: 'xcode8' } }
    it { expect(value[:osx_image]).to eq 'xcode8' }
    it { expect(info).to include [:info, :osx_image, :edge, ':osx_image is experimental and might be removed in the future'] }
  end

  describe 'source_key' do
    describe 'given a string' do
      let(:input) { { source_key: 'key' } }
      it { expect(value[:source_key]).to eq 'key' }
      it { expect(msgs).to be_empty }
    end

    describe 'given a secure var' do
      let(:input) { { source_key: { secure: 'secure' } } }
      it { expect(value[:source_key]).to eq(secure: 'secure') }
    end
  end

  stages = %i(before_install install before_script script after_script after_result
    after_success after_failure before_deploy after_deploy before_cache)

  stages.each do |stage|
    describe stage.to_s do
      describe 'given as a string' do
        let(:input) { { stage => 'foo' } }
        it { expect(value[stage]).to eq ['foo'] }
        it { expect(msgs).to be_empty }
      end

      describe 'given as an array' do
        let(:input) { { stage => ['foo', 'bar'] } }
        it { expect(value[stage]).to eq ['foo', 'bar'] }
        it { expect(msgs).to be_empty }
      end
    end
  end
end
