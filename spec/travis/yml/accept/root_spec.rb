describe Travis::Yml, 'root' do
  subject { described_class.load(yaml, opts) }

  describe 'default', defaults: true do
    yaml ''
    it { should serialize_to defaults }
    it { should have_msg [:info, :root, :default, key: 'language', default: 'ruby'] }
    it { should have_msg [:info, :root, :default, key: 'os', default: 'linux'] }
  end

  describe 'given a non-hash' do
    yaml 'foo'
    it { expect { subject }.to raise_error(Travis::Yml::InvalidConfigFormat) }
  end

  describe 'moves required keys to the front' do
    yaml %(
      osx_image: image
      os: osx
      language: ruby
    )
    it { should serialize_to language: 'ruby', os: ['osx'], osx_image: ['image'] }
  end

  describe 'does not warn on unknown key merge_mode' do
    yaml %(
      merge_mode: merge
    )
    it { should serialize_to merge_mode: 'merge' }
    it { should_not have_msg }
  end

  describe 'given an invalid type' do
    yaml %(
      rvm:
        foo: foo
    )
    it { should have_msg [:error, :rvm, :invalid_type, expected: :str, actual: :map, value: { foo: 'foo' }] }
  end

  describe 'corrects' do
    describe 'a typo' do
      yaml %(
        csript: ./foo
      )
      it { should serialize_to script: ['./foo'] }
      it { should have_msg [:warn, :root, :find_key, original: 'csript', key: 'script'] }
    end

    describe 'a typo on a key with a default', defaults: true do
      yaml %(
        langauge: shell
      )
      it { should serialize_to language: 'shell', os: ['linux'], dist: 'xenial' }
      it { should have_msg [:warn, :root, :find_key, original: 'langauge', key: 'language'] }
      it { should_not have_msg [:error, :root, :overwrite, key: 'langauge', other: 'language'] }
    end

    describe 'a camelized key' do
      yaml %(
        Language: ruby
      )
      it { should serialize_to language: 'ruby' }
      it { should have_msg [:info, :root, :underscore_key, original: 'Language', key: 'language'] }
    end

    describe 'a dasherized key' do
      yaml %(
        before-script: ./foo
      )
      it { should serialize_to before_script: ['./foo'] }
      it { should have_msg [:info, :root, :underscore_key, original: 'before-script', key: 'before_script'] }
    end

    describe 'a key supported by default language', support: true do
      yaml %(
        rubi: 2.3
      )
      it { should serialize_to rvm: ['2.3'] }
      it { should have_msg [:warn, :root, :find_key, original: 'rubi', key: 'ruby'] }
    end

    describe 'a key supported by given language' do
      yaml %(
        language: python
        pyhton: 2.7
      )
      it { should serialize_to language: 'python', python: ['2.7'] }
      it { should have_msg [:warn, :root, :find_key, original: 'pyhton', key: 'python'] }
    end

    describe 'a key supported by os' do
      yaml %(
        language: objective-c
        xcode_prject: project
      )
      it { should serialize_to language: 'objective-c', xcode_project: 'project' }
      it { should have_msg [:warn, :root, :find_key, original: 'xcode_prject', key: 'xcode_project'] }
    end

    describe 'a key unsupported by given language' do
      yaml %(
        language: ruby
        pyhton: 2.7
      )
      it { should serialize_to language: 'ruby', python: ['2.7'] }
      it { should have_msg [:warn, :root, :find_key, original: 'pyhton', key: 'python'] }
      it { should have_msg [:warn, :python, :unsupported, on_key: 'language', on_value: 'ruby', key: 'python', value: ['2.7']] }
    end
  end

  describe 'does not drop an unknown key' do
    yaml %(
      unknown: foo
    )
    it { should serialize_to unknown: 'foo' }
    it { should have_msg [:warn, :root, :unknown_key, key: 'unknown', value: 'foo'] }
  end

  describe 'does not drop an unknown key (2)' do
    yaml %(
      cd: foo
    )
    it { should serialize_to cd: 'foo' }
    it { should have_msg [:warn, :root, :unknown_key, key: 'cd', value: 'foo'] }
  end

  describe 'condition', drop: true do
    describe 'valid' do
      yaml %(
        if: 'branch = master'
      )
      it { should serialize_to if: 'branch = master' }
      it { should_not have_msg }
    end

    describe 'invalid' do
      yaml %(
        if: '= foo'
      )
      it { should serialize_to empty }
      it { should have_msg [:error, :if, :invalid_condition, condition: '= foo', message: nil] }
    end
  end

  ignore = %w(
    .configured
    :.configured
    :".configured"
    .result
    :.result
    :".result"
  )
  ignore.each do |key|
    describe "silently removes #{key}" do
      yaml %(
        language: ruby
        #{key}: foo
      )
      it { should serialize_to language: 'ruby' }
      it { should_not have_msg }
    end
  end

  describe 'given an unknown key' do
    yaml %(
      foo:
        foo: foo
    )
    it { should serialize_to foo: { foo: 'foo' } }
    it { should have_msg [:warn, :root, :unknown_key, key: 'foo', value: { foo: 'foo' }] }
  end

  describe 'given a misplaced key (up)', v2: true, migrate: true do
    yaml %(
      allow_failures:
        rvm: 2.4
    )
    it { should serialize_to matrix: { allow_failures: [rvm: '2.4'] } }
    it { should have_msg [:warn, :root, :migrate, key: 'allow_failures', to: 'matrix', value: [rvm: '2.4']] }
  end

  describe 'given a misplaced key (up), with the target being present, and nil', v2: true, migrate: true do
    yaml %(
      matrix:
      allow_failures:
        rvm: 2.4
    )
    let(:input) { { matrix: nil, allow_failures: [rvm: '2.4'] } }
    it { should serialize_to matrix: { allow_failures: [rvm: '2.4'] } }
    it { should have_msg [:warn, :root, :migrate, key: 'allow_failures', to: 'matrix', value: [rvm: '2.4']] }
    it { expect(msgs.size).to eq 1 }
  end

  describe 'given a misplaced key (up), with the target being a hash', v2: true, migrate: true do
    yaml %(
      matrix:
        include:
          - env: FOO=foo
        allow_failures:
          rvm: 2.4
    )
    it { should serialize_to matrix: { include: [{ env: ['FOO=foo'] }], allow_failures: [rvm: '2.4'] } }
    it { should have_msg [:warn, :root, :migrate, key: 'allow_failures', to: 'matrix', value: [rvm: '2.4']] }
    it { expect(msgs.size).to eq 1 }
  end

  describe 'given a misplaced key (up), with the target being a seq', v2: true, migrate: true do
    yaml %(
      matrix:
        - env: FOO=foo
      allow_failures:
        rvm: 2.4
    )
    it { should serialize_to matrix: { include: [{ env: ['FOO=foo'] }], allow_failures: [rvm: '2.4'] } }
    it { should have_msg [:warn, :root, :migrate, key: 'allow_failures', to: 'matrix', value: [rvm: '2.4']] }
    it { expect(msgs.size).to eq 1 }
  end

  describe 'given a misplaced key (down)', v2: true, migrate: true do
    yaml %(
      addons:
        script: ./foo
    )
    it { should serialize_to script: ['./foo'] }
    it { should have_msg [:warn, :addons, :migrate, key: 'script', to: 'root', value: 'foo'] }
    it { expect(msgs.size).to eq 1 }
  end

  describe 'given a misplaced key (down) on a nested section', v2: true, migrate: true do
    yaml %(
      addons:
        apt:
          sources:
            - source
          code_climate:
            repo_token: token
    )
    it { should serialize_to addons: { apt: { sources: ['source'] }, code_climate: { repo_token: 'token' } } }
    it { should have_msg [:warn, :'addons.apt', :migrate, key: 'code_climate', to: 'addons', value: { repo_token: 'token' }] }
    it { expect(msgs.size).to eq 1 }
  end

  describe 'given a misplaced key' do
    yaml %(
      file: file
    )
    it { should serialize_to file: 'file' }
    it { should have_msg [:warn, :root, :unknown_key, key: 'file', value: 'file'] }
  end

  describe 'given a broken map', line: true do
    yaml %(
      node_js: {"8"}
    )

    it { should have_msg [:error, :node_js, :invalid_type, expected: :str, actual: :map, value: { '8': nil }, line: 0] }
  end

  describe 'line number info', line: true do
    describe 'unknown_key' do
      yaml "unknown: str"
      it { should have_msg [:warn, :root, :unknown_key, key: 'unknown', value: 'str', line: 0] }
    end

    describe 'line number info on msgs', line: true do
      yaml "\nscript: { foo: bar }"
      it { should have_msg [:error, :script, :invalid_type, expected: :str, actual: :map, value: { foo: 'bar' }, line: 0] }
    end
  end

  describe 'duplicate keys (1)' do
    yaml %(
      one: 1
      one: 2
    )
    it { should have_msg [:error, :root, :duplicate_key, key: 'one'] }
    it { should_not have_msg [:error, :env, :duplicate_key, key: 'one'] }
  end

  describe 'duplicate keys (2)' do
    yaml %(
      env:
        one: 1
        one: 2
    )
    it { should_not have_msg [:error, :root, :duplicate_key, key: 'one'] }
    it { should have_msg [:error, :env, :duplicate_key, key: 'one'] }
  end

  describe 'given an invalid byte sequence in utf-8', line: true do
    yaml "if: tag =~ ^v\255"

    it { should_not have_msg }
  end
end
