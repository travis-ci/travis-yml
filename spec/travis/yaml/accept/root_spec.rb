describe Travis::Yaml, 'root' do
  let(:value) { subject.serialize }
  let(:opts)  { {} }

  subject { described_class.apply(input, opts) }

  describe 'default' do
    let(:input) { {} }
    it { expect(value).to eq(language: 'ruby', os: ['linux'], dist: 'precise', sudo: false) }
    it { expect(info).to include [:info, :language, :default, key: :language, default: 'ruby'] }
  end

  describe 'given a non-hash' do
    let(:input) { 'foo' }
    it { expect { value }.to raise_error(ArgumentError) }
  end

  describe 'moves required keys to the front' do
    let(:input) { { osx_image: 'image', os: 'osx', language: 'ruby' } }
    it { expect(value).to eq language: 'ruby', os: ['osx'], dist: 'precise', sudo: false, osx_image: 'image'  }
    it { expect(value.keys).to eq [:language, :os, :dist, :sudo, :osx_image] }
  end

  describe 'typos' do
    describe 'corrects a known key' do
      let(:input) { { csript: 'foo' } }
      it { expect(value[:script]).to eq ['foo'] }
      it { expect(msgs).to include [:warn, :root, :find_key, original: :csript, key: :script] }
    end

    describe 'corrects a camelized key' do
      let(:input) { { Language: 'ruby' } }
      it { expect(value[:language]).to eq 'ruby' }
      it { expect(msgs).to include [:warn, :root, :underscore_key, original: :Language, key: :language] }
    end

    describe 'corrects a dasherized key' do
      let(:input) { { :'before-script' => 'foo' } }
      it { expect(value[:before_script]).to eq ['foo'] }
      it { expect(msgs).to include [:warn, :root, :underscore_key, original: :'before-script', key: :before_script] }
    end

    describe 'corrects a supported key (language not given)' do
      let(:input) { { rubi: '2.3' } }
      it { expect(value[:rvm]).to eq ['2.3'] }
      it { expect(msgs).to include [:warn, :root, :find_key, original: :rubi, key: :ruby] }
    end

    describe 'corrects a supported key (os given via language)' do
      let(:input) { { language: 'objective-c', xcode_prject: 'project' } }
      it { expect(value[:xcode_project]).to eq 'project' }
      it { expect(msgs).to include [:warn, :root, :find_key, original: :xcode_prject, key: :xcode_project] }
    end

    describe 'corrects a supported key (language given)' do
      let(:input) { { language: 'python', pyhton: '2.7' } }
      it { expect(value[:python]).to eq ['2.7'] }
      it { expect(msgs).to include [:warn, :root, :find_key, original: :pyhton, key: :python] }
    end

    describe 'corrects an unsupported key (language given)' do
      let(:input) { { language: 'ruby', pyhton: 'foo' } }
      it { expect(value[:python]).to be_nil }
      it { expect(msgs).to include [:warn, :root, :find_key, original: :pyhton, key: :python] }
      it { expect(msgs).to include [:error, :python, :unsupported, on_key: :language, on_value: 'ruby', key: :python, value: ['foo']] }
    end

    describe 'does not correct an unknown key' do
      let(:input) { { unknown: 'foo' } }
      it { expect(value[:unknown]).to be_nil }
      it { expect(msgs.detect { |msg| msg[2] == :find_key }).to be_nil }
    end
  end

  describe 'drops an unknown key' do
    let(:input) { { unknown: 'foo' } }
    it { expect(value[:foo]).to be_nil }
    it { expect(msgs).to include [:error, :root, :unknown_key, key: :unknown, value: 'foo'] }
  end

  describe 'drops an unknown key (2)' do
    let(:input) { { cd: 'foo' } }
    it { expect(value[:cd]).to be_nil }
    it { expect(msgs).to include [:error, :root, :unknown_key, key: :cd, value: 'foo'] }
  end

  describe 'sudo' do
    describe 'given true' do
      let(:input) { { sudo: true } }
      it { expect(value[:sudo]).to eq true }
    end

    describe 'given the string on' do
      let(:input) { { sudo: 'on' } }
      it { expect(value[:sudo]).to eq true }
    end

    describe 'given the string yes' do
      let(:input) { { sudo: 'yes' } }
      it { expect(value[:sudo]).to eq true }
    end

    describe 'given the string enabled' do
      let(:input) { { sudo: 'enabled' } }
      it { expect(value[:sudo]).to eq true }
    end

    describe 'given the string required' do
      let(:input) { { sudo: 'required' } }
      it { expect(value[:sudo]).to eq true }
    end

    describe 'given false' do
      let(:input) { { sudo: false } }
      it { expect(value[:sudo]).to eq false }
    end

    describe 'given the string off' do
      let(:input) { { sudo: 'off' } }
      it { expect(value[:sudo]).to eq false }
    end

    describe 'given the string no' do
      let(:input) { { sudo: 'no' } }
      it { expect(value[:sudo]).to eq false }
    end

    describe 'given the string disabled' do
      let(:input) { { sudo: 'disabled' } }
      it { expect(value[:sudo]).to eq false }
    end

    describe 'given the string not required' do
      let(:input) { { sudo: 'not required' } }
      it { expect(value[:sudo]).to eq false }
    end
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

  ['.configured', ':.configured', ':".configured"', '.result', ':.result', ':".result"'].each do |key|
    describe "silently removes #{key} etc" do
      let(:input) { { key => 'foo' } }
      it { expect(value[key]).to be_nil }
      it { expect(msgs).to be_empty }
    end
  end

  describe 'given an unknown key' do
    let(:input) { { foo: [foo: 'foo'] } }
    it { expect(msgs).to include [:error, :root, :unknown_key, key: :foo, value: [foo: 'foo']] }
    # it { msgs.each { |msg| p msg } }
    it { expect(msgs.size).to eq 1 }
  end

  describe 'given a misplaced key (up)' do
    let(:input) { { allow_failures: [rvm: '2.4'] } }
    it { expect(value[:matrix]).to eq allow_failures: [rvm: '2.4'] }
    it { expect(msgs).to include [:warn, :root, :migrate, key: :allow_failures, to: :matrix, value: [rvm: '2.4']] }
  end

  describe 'given a misplaced key (up), with the target being present, and nil' do
    let(:input) { { matrix: nil, allow_failures: [rvm: '2.4'] } }
    it { expect(value[:matrix]).to eq allow_failures: [rvm: '2.4'] }
    it { expect(msgs).to include [:warn, :root, :migrate, key: :allow_failures, to: :matrix, value: [rvm: '2.4']] }
    it { expect(msgs.size).to eq 1 }
  end

  describe 'given a misplaced key (up), with the target being a hash' do
    let(:input) { { matrix: { include: [{ env: 'FOO=foo' }] }, allow_failures: [rvm: '2.4'] } }
    it { expect(value[:matrix]).to eq include: [{ env: 'FOO=foo' }], allow_failures: [rvm: '2.4'] }
    it { expect(msgs).to include [:warn, :root, :migrate, key: :allow_failures, to: :matrix, value: [rvm: '2.4']] }
    it { expect(msgs.size).to eq 1 }
  end

  describe 'given a misplaced key (up), with the target being a seq' do
    let(:input) { { matrix: [{ env: 'FOO=foo' }], allow_failures: [rvm: '2.4'] } }
    it { expect(value[:matrix]).to eq include: [{ env: 'FOO=foo' }], allow_failures: [rvm: '2.4'] }
    it { expect(msgs).to include [:warn, :root, :migrate, key: :allow_failures, to: :matrix, value: [rvm: '2.4']] }
    it { expect(msgs.size).to eq 1 }
  end

  describe 'given a misplaced key (down)' do
    let(:input) { { addons: { script: 'foo' } } }
    it { expect(value[:script]).to eq ['foo'] }
    it { expect(msgs).to include [:warn, :addons, :migrate, key: :script, to: :root, value: 'foo'] }
    it { expect(msgs).to include [:warn, :root, :empty, key: :addons] }
    it { expect(msgs.size).to eq 2 }
  end

  describe 'given a misplaced key (down) on a nested section' do
    let(:input) { { addons: { apt: { sources: ['source'], code_climate: { repo_token: 'token' } } } } }
    it { expect(value[:addons]).to eq apt: { sources: ['source'] }, code_climate: { repo_token: 'token' } }
    it { expect(msgs).to include [:warn, :'addons.apt', :migrate, key: :code_climate, to: :addons, value: { repo_token: 'token' }] }
    it { expect(msgs.size).to eq 1 }
  end

  describe 'given an unknown key with a secure' do
    xit
  end

  describe 'given an invalid type' do
    let(:input) { { rvm: { foo: 'foo' } } }
    it { expect(msgs).to include [:error, :rvm, :invalid_type, expected: :str, actual: :map, value: { foo: 'foo' }] }
    it { expect(msgs.size).to eq 1 }
  end

  describe 'given a broken scalar that is parsed into a hash' do
    let(:key)   { 'curl -j -L -H "Cookie' }
    let(:value) { 'cookie" $JAVA_URL > java/$JAVA_FILE' }
    let(:input) { { script: [key => value] } }
    it { expect(subject.serialize[:script]).to eq ["#{key}: #{value}"] }
    it { expect(msgs).to include [:warn, :script, :repair, key: key, value: value, to: "#{key}: #{value}"] }
  end

  describe 'given a broken scalar that is parsed into a hash (2)' do
    let(:key)   { 'sudo pip install --upgrade natcap.versioner>=0.3.1 --egg --no-binary :all' }
    let(:input) { { script: [key => nil] } }
    it { expect(subject.serialize[:script]).to eq ["#{key}:"] }
    it { expect(msgs).to include [:warn, :script, :repair, key: key, value: nil, to: "#{key}:"] }
  end

  describe 'given a misplaced key (down), resulting in an invalid node if migrated' do
    let(:input) { { file: 'file' } }
    it { expect(subject.serialize[:file]).to be_nil }
    it { expect(msgs).to include [:error, :root, :misplaced_key, key: :file, value: 'file'] }
  end
end
