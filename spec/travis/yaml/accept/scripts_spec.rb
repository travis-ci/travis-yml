describe Travis::Yaml, 'scripts' do
  let(:config) { subject.serialize }

  subject { described_class.apply(input) }

  describe 'script' do
    describe 'given a string' do
      let(:input) { { script: 'foo' } }
      it { expect(config[:script]).to eq ['foo'] }
    end

    describe 'given an array' do
      let(:input) { { script: ['foo', 'bar'] } }
      it { expect(config[:script]).to eq ['foo', 'bar'] }
    end

    describe 'after env' do
      let(:input) { { env: ['FOO=foo'], script: 'foo' } }
      it { expect(config[:script]).to eq ['foo'] }
    end
  end

  stages = %i(
    before_install
    install
    before_script
    script
    after_script
    after_result
    after_success
    after_failure
    before_deploy
    after_deploy
    before_cache
  )

  stages.each do |stage|
    describe stage.to_s do
      describe 'given a string' do
        let(:input) { { stage => 'foo' } }
        it { expect(config[stage]).to eq ['foo'] }
      end

      describe 'given an array' do
        let(:input) { { stage => ['foo'] } }
        it { expect(config[stage]).to eq ['foo'] }
      end
    end
  end

  describe 'on_success (alias)' do
    let(:input) { { on_success: 'foo' } }
    it { expect(config[:after_success]).to eq ['foo'] }
  end

  describe 'on_failure (alias)' do
    let(:input) { { on_failure: 'foo' } }
    it { expect(config[:after_failure]).to eq ['foo'] }
  end
end
