describe Travis::Yaml, 'stages' do
  let(:config) { subject.to_h }

  subject { described_class.apply(source) }

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

  it { expect(Travis::Yaml::Spec::Def::Root::STAGES).to eq stages }

  stages.each do |stage|
    describe stage.to_s do
      describe 'given a string' do
        let(:source) { { stage => 'foo' } }
        it { expect(config[stage]).to eq ['foo'] }
      end

      describe 'given an array' do
        let(:source) { { stage => ['foo'] } }
        it { expect(config[stage]).to eq ['foo'] }
      end
    end
  end
end
