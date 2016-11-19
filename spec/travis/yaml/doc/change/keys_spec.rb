describe Travis::Yaml::Doc::Change::Keys do
  let(:msgs)   { subject.msgs }
  let(:spec)   { Travis::Yaml.expanded }
  let(:node)   { build(nil, :root, value, {}) }
  let(:result) { subject.raw }
  let(:keys)   { result.keys }

  subject { change(build(nil, :root, value, {})) }

  describe 'given a string' do
    let(:value) { { 'language' => nil } }
    it { expect(keys).to include :language }
    it { expect(msgs).to be_empty }
  end

  describe 'given an aliased key' do
    let(:value) { { ruby: nil } }
    it { expect(keys).to include :rvm }
    it { expect(msgs).to include [:info, :root, :alias, alias: :ruby, key: :rvm] }
  end

  describe 'downcase' do
    describe 'given an uppercase key on root' do
      let(:value) { { ENV: nil } }
      it { expect(keys).to include :env }
      it { expect(msgs).to include [:warn, :root, :underscore_key, original: :ENV, key: :env] }
    end

    describe 'given an unknown, uppercase key on root' do
      let(:value) { { FOO: nil } }
      it { expect(keys).to include :FOO }
    end

    describe 'given an unmapped, uppercase key on strict: false' do
      let(:value) { { env: { DEBUG: true } } }
      it { expect(result[:env][:matrix]).to eq ['DEBUG=true'] }
      it { expect(msgs).to be_empty }
    end

    describe 'given a unmapped, misplaced, uppercase key on strict: false' do
      let(:value) { { env: { CONFIG: 'config' } } }
      it { expect(result[:env][:matrix]).to eq ['CONFIG=config'] }
      it { expect(msgs).to be_empty }
    end

    describe 'given a misplaced, uppercase key' do
      let(:value) { { CONFIG: 'config' } }
      it { expect(keys).to include :config }
      it { expect(msgs).to include [:warn, :root, :underscore_key, original: :CONFIG, key: :config] }
    end

    describe 'given an aliased, uppercase key' do
      let(:value) { { RUBY: '2.3' } }
      it { expect(keys).to include :rvm }
    end
  end

  describe 'clean' do
    describe 'given a key with a leading colon' do
      let(:value) { { :':rvm' => '2.3' } }
      it { expect(keys).to include :rvm }
      it { expect(msgs).to include [:warn, :root, :clean_key, original: :':rvm', key: :rvm] }
    end

    describe 'given a key with a leading dash' do
      let(:value) { { :'-rvm' => '2.3' } }
      it { expect(keys).to include :rvm }
      it { expect(msgs).to include [:warn, :root, :clean_key, original: :'-rvm', key: :rvm] }
    end

    describe 'given a key with a tailing dash' do
      let(:value) { { :'rvm-' => '2.3' } }
      it { expect(keys).to include :rvm }
      it { expect(msgs).to include [:warn, :root, :clean_key, original: :'rvm-', key: :rvm] }
    end

    describe 'given a known dasherized key' do
      let(:value) { { :'before-install' => 'foo' } }
      it { expect(keys).to include :before_install }
      it { expect(msgs).to include [:warn, :root, :underscore_key, original: :'before-install', key: :before_install] }
    end

    describe 'given a misplaced dasherized key' do
      let(:value) { { :'dry-run' => true } }
      it { expect(keys).to include :dry_run }
      it { expect(msgs).to include [:warn, :root, :underscore_key, original: :'dry-run', key: :dry_run] }
    end

    describe 'given a spaced key' do
      let(:value) { { :'before install' => 'foo' } }
      it { expect(keys).to include :before_install }
      it { expect(msgs).to include [:warn, :root, :clean_key, original: :'before install', key: :before_install] }
    end

    describe 'given a spaced key with an underscore' do
      let(:value) { { :'before _install' => 'foo' } }
      it { expect(keys).to include :before_install }
      it { expect(msgs).to include [:warn, :root, :clean_key, original: :'before _install', key: :before_install] }
    end

    describe 'given a key with a lot of leading whitespace' do
      let(:value) { { :"\u00A0\t before_install" => 'foo' } }
      it { expect(keys).to include :before_install }
      it { expect(msgs).to include [:warn, :root, :strip_key, original: :"\u00A0\t before_install", key: :before_install] }
    end

    describe 'given a key with garbage chars' do
      let(:value) { { :'ï»¿language' => 'java' } }
      it { expect(keys).to include :language }
      it { expect(msgs).to include [:warn, :root, :clean_key, original: :'ï»¿language', key: :language] }
    end

    describe 'given the key "// install"' do
      let(:value) { { :'"// install"' => 'foo' } }
      it { expect(keys).to include :install }
      it { expect(msgs).to include [:warn, :root, :clean_key, original: :'"// install"', key: :install] }
    end

    describe 'given an aliased key with a leading dash' do
      let(:value) { { :'-ruby' => '2.3' } }
      it { expect(keys).to include :rvm }
      it { expect(msgs).to include [:warn, :root, :clean_key, original: :'-ruby', key: :ruby] }
      it { expect(msgs).to include [:info, :root, :alias, alias: :ruby, key: :rvm] }
    end

    describe 'given an aliased key with a tailing dash' do
      let(:value) { { :'ruby-' => '2.3' } }
      it { expect(keys).to include :rvm }
      it { expect(msgs).to include [:warn, :root, :clean_key, original: :'ruby-', key: :ruby] }
      it { expect(msgs).to include [:info, :root, :alias, alias: :ruby, key: :rvm] }
    end

    describe 'given an aliased key with a leading colon' do
      let(:value) { { :':ruby' => '2.3' } }
      it { expect(keys).to include :rvm }
      it { expect(msgs).to include [:warn, :root, :clean_key, original: :':ruby', key: :ruby] }
      it { expect(msgs).to include [:info, :root, :alias, alias: :ruby, key: :rvm] }
    end

    describe 'given an aliased, misplaced, dasherized key' do
      let(:value) { { :'on-failure' => 'foo' } }
      it { expect(keys).to include :after_failure }
      it { expect(msgs).to include [:warn, :root, :underscore_key, original: :'on-failure', key: :on_failure] }
      it { expect(msgs).to include [:info, :root, :alias, alias: :on_failure, key: :after_failure] }
    end

    describe 'given an aliased, misplaced, spaced key' do
      let(:value) { { :'on failure' => 'foo' } }
      it { expect(keys).to include :after_failure }
      it { expect(msgs).to include [:warn, :root, :clean_key, original: :'on failure', key: :on_failure] }
      it { expect(msgs).to include [:info, :root, :alias, alias: :on_failure, key: :after_failure] }
    end
  end

  describe 'migrate down' do
    describe 'resulting in a valid section (target map)' do
      let(:value) { { bundler: true } }
      it { expect(result[:cache]).to eq value }
      it { expect(msgs).to include [:warn, :root, :migrate, key: :bundler, to: :cache, value: true] }
    end

    describe 'resulting in a valid section (target seq)' do
      let(:value) { { include: { rvm: '2.4' } } }
      it { expect(result[:matrix]).to eq include: [rvm: '2.4'] }
      it { expect(msgs).to include [:warn, :root, :migrate, key: :include, to: :matrix, value: { rvm: '2.4' }] }
    end

    describe 'resulting in an invalid section' do
      let(:value) { { include: [:foo] } }
      it { expect(result[:matrix]).to be_nil }
      it { expect(result[:include]).to eq [:foo] }
    end
  end

  describe 'migrate up' do
    describe 'resulting in a valid section' do
      let(:value) { { addons: { script: ['rake'] } } }
      it { expect(result[:script]).to eq ['rake'] }
      it { expect(msgs).to include [:warn, :addons, :migrate, key: :script, to: :root, value: ['rake']] }
    end

    describe 'resulting in an invalid section' do
      let(:value) { { cache: { deploy: true } } }
      it { expect(result[:cache]).to eq deploy: true }
      it { expect(result[:deploy]).to be_nil }
    end

    describe 'not sure what, a key that migrates to after the parent key?' do
      let(:value) { { deploy: { matrix: nil, provider: 'heroku' } } }
      it { expect(result[:deploy]).to eq [provider: 'heroku'] }
      it { expect(result[:matrix]).to eq nil }
      it { expect(keys).to include :matrix }
    end

    # not possible because root.env will be prefixed to root.env.matrix by this time
    # we'd need to reuse the verified node somehow
    describe 'merging a seq with an existing seq' do
      let(:value) { { env: ['FOO=foo'], addons: { env: ['BAR=bar'] } } }
      xit { expect(result[:env]).to eq ['FOO=foo', 'BAR=bar'] }
      xit { expect(result[:addons]).to eq nil }
    end
  end
end

