describe Travis::Yml, 'matrix' do
  subject { described_class.apply(parse(yaml), opts) }

  describe 'fast_finish' do
    describe 'given true' do
      yaml %(
        matrix:
          fast_finish: true
      )
      it { should serialize_to matrix: { fast_finish: true } }
      it { should_not have_msg }
    end

    describe 'on alias jobs' do
      yaml %(
        jobs:
          fast_finish: true
      )
      it { should serialize_to matrix: { fast_finish: true } }
      it { should have_msg [:info, :root, :alias, type: :key, alias: 'jobs', obj: 'matrix'] }
    end

    describe 'alias fast_failure' do
      yaml %(
        matrix:
          fast_failure: true
      )
      it { should serialize_to matrix: { fast_finish: true } }
      it { should have_msg [:info, :matrix, :alias, type: :key, alias: 'fast_failure', obj: 'fast_finish'] }
    end
  end

  describe 'prefix include' do
    describe 'given a map (rvm)' do
      yaml %(
        matrix:
          rvm: 2.3
      )
      it { should serialize_to matrix: { include: [rvm: '2.3'] } }
      it { should_not have_msg }
    end

    describe 'given a map (script)' do
      yaml %(
        matrix:
          script: str
      )
      it { should serialize_to matrix: { include: [script: ['str']] } }
      it { should_not have_msg }
    end

    describe 'given a map (stage)' do
      yaml %(
        matrix:
          stage: str
      )
      it { should serialize_to matrix: { include: [stage: 'str'] } }
      it { should_not have_msg }
    end

    describe 'given a seq of maps' do
      yaml %(
        matrix:
          - rvm: 2.3
          - rvm: 2.4
      )
      it { should serialize_to matrix: { include: [{ rvm: '2.3' }, { rvm: '2.4' }] } }
      it { should_not have_msg }
    end

    describe 'given a seq of strings (misplaced env.matrix)' do
      yaml %(
        matrix:
          - FOO=foo
      )
      it { should have_msg [:error, :matrix, :invalid_type, expected: :map, actual: :seq, value: ['FOO=foo']] }
    end

    describe 'given a misplaced key :allow_failures', v2: true, migrate: true do
      yaml %(
        allow_failures:
          - rvm: 2.3
      )
      it { should serialize_to matrix: { allow_failures: [rvm: '2.3'] } }
      it { should_not have_msg }
    end

    describe 'given a misplaced alias :allowed_failures (typo)', v2: true, migrate: true do
      yaml %(
        allowed_failures:
          - rvm: 2.3
      )
      it { should serialize_to matrix: { allow_failures: [rvm: '2.3'] } }
      it { should have_msg [:warn, :root, :migrate, key: 'allow_failures', to: 'matrix', value: [rvm: '2.3']] }
    end
  end

  describe 'include' do
    describe 'given true', drop: true do
      yaml %(
        matrix:
          include: true
      )
      it { should serialize_to empty }
      it { should have_msg [:error, :"matrix.include", :invalid_type, expected: :map, actual: :bool, value: true] }
    end

    describe 'given a seq of maps' do
      yaml %(
        matrix:
          include:
            - rvm: 2.3
              stage: str
      )
      it { should serialize_to matrix: { include: [rvm: '2.3', stage: 'str'] } }
      it { should_not have_msg }
    end

    describe 'given a map' do
      yaml %(
        matrix:
          include:
            rvm: 2.3
      )
      it { should serialize_to matrix: { include: [rvm: '2.3'] } }
      it { should_not have_msg }
    end

    describe 'given a nested map with a broken env string (missing newline)', drop: true do
      yaml %(
        matrix:
          include:
            mono:
              4.0.5env: EDITOR=nvim
      )
      it { should serialize_to empty }
      it { should have_msg [:error, :'matrix.include.mono', :invalid_type, expected: :str, actual: :map, value: { :'4.0.5env' => 'EDITOR=nvim' }] }
    end

    describe 'given a seq of maps (with env given as a map)' do
      yaml %(
        matrix:
          include:
            - rvm: 2.3
              env:
                FOO: foo
      )
      it { should serialize_to matrix: { include: [rvm: '2.3', env: [FOO: 'foo']] } }
      it { should_not have_msg }
    end

    describe 'given a seq of maps (with rvm given as a string)' do
      yaml %(
        matrix:
          include:
            - rvm: 2.3
              env: FOO=foo
      )
      it { should serialize_to matrix: { include: [rvm: '2.3', env: [FOO: 'foo']] } }
      it { should_not have_msg }
    end

    describe 'given a seq of maps (with env given as a seq of strings)' do
      yaml %(
        matrix:
          include:
            - rvm: 2.3
              env:
              - FOO=foo
              - BAR=bar
      )
      it { should serialize_to matrix: { include: [rvm: '2.3', env: [{ FOO: 'foo' }, { BAR: 'bar' }]] } }
    end

    describe 'given env.global with a seq of maps' do
      yaml %(
        matrix:
          include:
            - env:
                global:
                  - FOO: true
      )
      # this isn't great, but fixing it would end up with confusing error messages
      it { should serialize_to matrix: { include: [env: [global: [{ FOO: true }]]] } }
      it { should_not have_msg }
    end

    describe 'given language (str)' do
      yaml %(
        matrix:
          include:
            language: ruby
      )
      it { should serialize_to matrix: { include: [language: 'ruby'] } }
      it { should_not have_msg }
    end

    describe 'given language (seq)' do
      yaml %(
        matrix:
          include:
            language:
            - ruby
      )
      it { should serialize_to matrix: { include: [language: 'ruby'] } }
      it { should have_msg [:warn, :'matrix.include.language', :unexpected_seq, value: 'ruby'] }
    end

    describe 'given language with a typo' do
      yaml %(
        matrix:
          include:
            language: ruby`
      )
      it { should serialize_to matrix: { include: [language: 'ruby'] } }
      it { should have_msg [:warn, :'matrix.include.language', :find_value, original: 'ruby`', value: 'ruby'] }
    end

    describe 'given jdk (str)' do
      yaml %(
        matrix:
          include:
          - language: ruby
            jdk: str
      )
      it { should serialize_to matrix: { include: [language: 'ruby', jdk: 'str'] } }
      it { should_not have_msg }
    end

    describe 'given jdk (seq)' do
      yaml %(
        matrix:
          include:
          - language: ruby
            jdk:
            - str
      )
      it { should serialize_to matrix: { include: [language: 'ruby', jdk: 'str'] } }
      it { should have_msg [:warn, :'matrix.include.jdk', :unexpected_seq, value: 'str'] }
    end

    describe 'given compiler (str)' do
      yaml %(
        matrix:
          include:
          - language: cpp
            compiler: str
      )
      it { should serialize_to matrix: { include: [language: 'cpp', compiler: 'str'] } }
      it { should_not have_msg }
    end

    describe 'given compiler (seq)' do
      yaml %(
        matrix:
          include:
          - language: cpp
            compiler:
            - str
      )
      it { should serialize_to matrix: { include: [language: 'cpp', compiler: 'str'] } }
      it { should have_msg [:warn, :'matrix.include.compiler', :unexpected_seq, value: 'str'] }
    end

    describe 'given licenses' do
      yaml %(
        matrix:
          include:
          - language: android
            android:
              licenses:
                - str
      )
      it { should serialize_to matrix: { include: [language: 'android', android: { licenses: ['str'] }] } }
      it { should_not have_msg }
    end

    describe 'unknown value, with an unsupported key' do
      yaml %(
        matrix:
          include:
            language: node_js - 9
            compiler: gcc
      )
      it { should serialize_to matrix: { include: [language: 'node_js', compiler: 'gcc'] } }
      it { should have_msg [:warn, :'matrix.include.language', :clean_value, original: 'node_js - 9', value: 'node_js'] }
      it { should have_msg [:warn, :'matrix.include.compiler', :unsupported, on_key: 'language', on_value: 'node_js', key: 'compiler', value: 'gcc'] }
    end

    describe 'given a name' do
      yaml %(
        matrix:
          include:
            name: name
      )
      it { should serialize_to matrix: { include: [name: 'name'] } }
      it { should_not have_msg }
    end

    describe 'given duplicate names' do
      yaml %(
        matrix:
          include:
            - name: name
            - name: name
      )
      it { should serialize_to matrix: { include: [{ name: 'name' }, { name: 'name' }] } }
      it { should have_msg [:info, :'matrix.include', :duplicate, duplicates: 'name: name'] }
    end

    describe 'given addons' do
      yaml %(
        matrix:
          include:
            - addons:
                apt: package
      )
      it { should serialize_to matrix: { include: [addons: { apt: { packages: ['package'] } }] } }
      it { should_not have_msg }
    end

    describe 'given branches' do
      yaml %(
        matrix:
          include:
            - branches:
                only: master
      )
      it { should serialize_to matrix: { include: [branches: { only: ['master'] }] } }
      it { should_not have_msg }
    end

    describe 'given a condition' do
      describe 'valid' do
        yaml %(
          matrix:
            include:
              - if: 'branch = master'
        )
        it { should serialize_to matrix: { include: [if: 'branch = master'] } }
        it { should_not have_msg }
      end

      describe 'invalid' do
        yaml %(
          matrix:
            include:
              if: '= foo'
        )
        it { should serialize_to empty }
        it { should have_msg [:error, :'matrix.include.if', :invalid_condition, condition: '= foo'] }
      end
    end

    describe 'given a misplaced env' do
      yaml %(
        matrix:
          include:
            - os: linux
          env:
            - FOO=str
      )
      it { should serialize_to matrix: { include: [os: 'linux'], env: ['FOO=str'] } }
      it { should have_msg [:warn, :matrix, :unknown_key, key: 'env', value: ['FOO=str']] }
    end

    describe 'given a misplaced key' do
      yaml %(
        matrix:
          include:
            env:
              DEBUG: on
      )
      it { should serialize_to matrix: { include: [env: [DEBUG: 'on']] } }
      it { should_not have_msg }
    end

    describe 'given an unknown os' do
      yaml %(
        matrix:
          include:
            - os: unknown
      )
      it { should serialize_to matrix: { include: [os: 'linux'] } }
      it { should have_msg [:warn, :'matrix.include.os', :unknown_default, value: 'unknown', default: 'linux'] }
    end
  end

  [:exclude, :allow_failures].each do |key|
    describe key.to_s do
      describe 'given a map' do
        yaml %(
          matrix:
            #{key}:
              rvm: 2.3
        )
        it { should serialize_to matrix: { key => [rvm: '2.3'] } }
        it { should_not have_msg }
      end

      describe 'given a seq of maps' do
        yaml %(
          matrix:
            #{key}:
              - rvm: 2.3
        )
        it { should serialize_to matrix: { key => [rvm: '2.3'] } }
        it { should_not have_msg }
      end

      describe 'given true', drop: true do
        yaml %(
          matrix:
            #{key}: true
        )
        it { should serialize_to empty }
        it { should have_msg [:error, :"matrix.#{key}", :invalid_type, expected: :map, actual: :bool, value: true] }
      end

      describe 'default language', defaults: true do
        yaml %(
          matrix:
            #{key}:
              rvm: 2.3
        )
        it { should serialize_to language: 'ruby', os: ['linux'], matrix: { key => [rvm: '2.3'] } }
      end

      describe 'given language' do
        yaml %(
          matrix:
            #{key}:
              language: ruby
        )
        it { should serialize_to matrix: { key => [language: 'ruby'] } }
        it { should_not have_msg }
      end

      describe 'env' do
        describe 'given as string' do
          yaml %(
            matrix:
              #{key}:
                env: 'FOO=foo BAR=bar'
          )
          it { should serialize_to matrix: { key => [env: [{ FOO: 'foo' }, { BAR: 'bar' }]] } }
          it { should_not have_msg }
        end

        describe 'given as a seq of strings' do
          yaml %(
            matrix:
              #{key}:
                env:
                  - FOO=foo
                  - BAR=bar
          )
          it { should serialize_to matrix: { key => [env: [{ FOO: 'foo' }, { BAR: 'bar' }]] } }
          it { should_not have_msg }
        end

        describe 'given as a map' do
          yaml %(
            matrix:
              #{key}:
                env:
                  FOO: foo
                  BAR: bar
          )
          it { should serialize_to matrix: { key => [env: [{ FOO: 'foo' }, { BAR: 'bar' }]] } }
          it { should_not have_msg }
        end

        describe 'given as a seq of maps' do
          yaml %(
            matrix:
              #{key}:
                env:
                  - FOO: foo
                  - BAR: bar
          )
          it { should serialize_to matrix: { key => [env: [{ FOO: 'foo' }, { BAR: 'bar' }]] } }
          it { should_not have_msg }
        end
      end

      describe 'given licenses' do
        yaml %(
          matrix:
            #{key}:
            - language: android
              android:
                licenses:
                  - str
        )
        it { should serialize_to matrix: { key => [language: 'android', android: { licenses: ['str'] }] } }
        it { should_not have_msg }
      end

      describe 'given an unsupported key' do
        describe 'language given on root' do
          yaml %(
            language: ruby
            matrix:
              #{key}:
                - rvm: 2.3
                  python: 3.5
          )
          it { should serialize_to language: 'ruby', matrix: { key => [rvm: '2.3', python: '3.5'] } }
          it { should have_msg [:warn, :"matrix.#{key}.python", :unsupported, on_key: 'language', on_value: 'ruby', key: 'python', value: '3.5'] }
        end

        describe "language given on matrix.#{key}" do
          yaml %(
            matrix:
              #{key}:
                - language: ruby
                  rvm: 2.3
                  python: 3.5
          )
          it { should serialize_to matrix: { key => [language: 'ruby', rvm: '2.3', python: '3.5'] } }
          it { should have_msg [:warn, :"matrix.#{key}.python", :unsupported, on_key: 'language', on_value: 'ruby', key: 'python', value: '3.5'] }
        end

        describe 'in separate entries' do
          yaml %(
            language: ruby
            matrix:
              #{key}:
                - rvm: 2.3
                - python: 3.5
          )
          it { should serialize_to language: 'ruby', matrix: { key => [{ rvm: '2.3' }, { python: '3.5' }] } }
          it { should have_msg [:warn, :"matrix.#{key}.python", :unsupported, on_key: 'language', on_value: 'ruby', key: 'python', value: '3.5'] }
        end
      end
    end
  end

  describe 'allow_failures' do
    describe "alias allowed_failures" do
      yaml %(
        matrix:
          allowed_failures:
            rvm: 2.3
      )
      it { should serialize_to matrix: { allow_failures: [rvm: '2.3'] } }
      it { should have_msg [:info, :matrix, :alias, type: :key, alias: 'allowed_failures', obj: 'allow_failures'] }
    end

    describe 'allow_failures given a seq of strings (common mistake)', drop: true do
      yaml %(
        matrix:
          allowed_failures:
            - 2.3
      )
      it { should serialize_to empty }
      it { should have_msg [:error, :'matrix.allow_failures', :invalid_type, expected: :map, actual: :str, value: '2.3'] }
    end

    describe 'misplaced on root', v2: true, migrate: true do
      yaml %(
      )
      it { should serialize_to matrix: { allow_failures: [rvm: '2.3'] } }
      it { should have_msg [:warn, :root, :migrate, key: 'allow_failures', to: 'matrix', value: [rvm: '2.3']] }
    end

    describe 'alias allowed_failures, misplaced on root', v2: true, migrate: true do
      yaml %(
        allowed_failures:
          rvm: 2.3
      )
      it { should serialize_to matrix: { allow_failures: [rvm: '2.3'] } }
      it { should have_msg [:warn, :root, :migrate, key: 'allow_failures', to: 'matrix', value: [rvm: '2.3']] }
    end
  end

  describe 'misplaced keys', v2: true, migrate: true do
    yaml %(
      matrix:
        include:
          - apt:
              packages: clang
          - apt:
    )
    it { should serialize_to matrix: { include: [addons: { apt: { packages: ['clang'] } }] } }
    it { should have_msg [:warn, :'matrix.include', :migrate, key: 'apt', to: 'addons', value: { packages: ['clang'] }] }
    it { should have_msg [:warn, :'matrix.include', :migrate, key: 'apt', to: 'addons', value: nil] }
  end

  describe 'duplicate values' do
    yaml %(
      matrix:
        include:
          - if: type = cron
            node_js: 10.7
            env: TRY_CONFIG=ember-beta
          - if: type = cron
            node_js: 10.7
            env: TRY_CONFIG=ember-data-beta
          - node_js: 10.7
    )
    it { should_not have_msg }
  end
end
