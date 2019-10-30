describe Travis::Yml, 'jobs' do
  subject { described_class.apply(parse(yaml), opts) }

  describe 'fast_finish' do
    describe 'given true' do
      yaml %(
        jobs:
          fast_finish: true
      )
      it { should serialize_to jobs: { fast_finish: true } }
      it { should_not have_msg }
    end

    describe 'on alias matrix' do
      yaml %(
        matrix:
          fast_finish: true
      )
      it { should serialize_to jobs: { fast_finish: true } }
      it { should have_msg [:info, :root, :alias_key, alias: 'matrix', key: 'jobs'] }
    end

    describe 'overwrite, using both matrix and jobs (1)' do
      yaml %(
        matrix:
          fast_finish: true
        jobs:
          - script: one
      )
      it { should serialize_to jobs: { fast_finish: true } }
      it { should have_msg [:info, :root, :alias_key, alias: 'matrix', key: 'jobs'] }
      it { should have_msg [:error, :root, :overwrite, key: 'matrix', other: 'jobs'] }
    end

    describe 'overwrite, using both matrix and jobs (2)' do
      yaml %(
        jobs:
          - script: one
        matrix:
          fast_finish: true
      )
      it { should serialize_to jobs: { fast_finish: true } }
      it { should have_msg [:info, :root, :alias_key, alias: 'matrix', key: 'jobs'] }
      it { should have_msg [:error, :root, :overwrite, key: 'matrix', other: 'jobs'] }
    end

    describe 'alias fast_failure' do
      yaml %(
        jobs:
          fast_failure: true
      )
      it { should serialize_to jobs: { fast_finish: true } }
      it { should have_msg [:info, :jobs, :alias_key, alias: 'fast_failure', key: 'fast_finish'] }
    end
  end

  describe 'prefix include' do
    describe 'given a map (rvm)' do
      yaml %(
        jobs:
          rvm: 2.3
      )
      it { should serialize_to jobs: { include: [rvm: '2.3'] } }
      it { should_not have_msg }
    end

    describe 'given a map (script)' do
      yaml %(
        jobs:
          script: str
      )
      it { should serialize_to jobs: { include: [script: ['str']] } }
      it { should_not have_msg }
    end

    describe 'given a map (stage)' do
      yaml %(
        jobs:
          stage: str
      )
      it { should serialize_to jobs: { include: [stage: 'str'] } }
      it { should_not have_msg }
    end

    describe 'given a seq of maps' do
      yaml %(
        jobs:
          - rvm: 2.3
          - rvm: 2.4
      )
      it { should serialize_to jobs: { include: [{ rvm: '2.3' }, { rvm: '2.4' }] } }
      it { should_not have_msg }
    end

    describe 'given a seq of strings (misplaced env.jobs)' do
      yaml %(
        jobs:
          - FOO=foo
      )
      it { should have_msg [:error, :jobs, :invalid_type, expected: :map, actual: :seq, value: ['FOO=foo']] }
    end

    describe 'given a misplaced key :allow_failures', v2: true, migrate: true do
      yaml %(
        allow_failures:
          - rvm: 2.3
      )
      it { should serialize_to jobs: { allow_failures: [rvm: '2.3'] } }
      it { should_not have_msg }
    end

    describe 'given a misplaced alias :allowed_failures (typo)', v2: true, migrate: true do
      yaml %(
        allowed_failures:
          - rvm: 2.3
      )
      it { should serialize_to jobs: { allow_failures: [rvm: '2.3'] } }
      it { should have_msg [:warn, :root, :migrate, key: 'allow_failures', to: 'jobs', value: [rvm: '2.3']] }
    end
  end

  describe 'include' do
    describe 'given true', drop: true do
      yaml %(
        jobs:
          include: true
      )
      it { should serialize_to empty }
      it { should have_msg [:error, :"jobs.include", :invalid_type, expected: :map, actual: :bool, value: true] }
    end

    describe 'given a seq of maps' do
      yaml %(
        jobs:
          include:
            - rvm: 2.3
              stage: str
      )
      it { should serialize_to jobs: { include: [rvm: '2.3', stage: 'str'] } }
      it { should_not have_msg }
    end

    describe 'given osx_image' do
      yaml %(
        jobs:
          include:
            - osx_image: str
      )
      it { should serialize_to jobs: { include: [osx_image: 'str'] } }
      it { should_not have_msg }
    end

    describe 'given a map' do
      yaml %(
        jobs:
          include:
            rvm: 2.3
      )
      it { should serialize_to jobs: { include: [rvm: '2.3'] } }
      it { should_not have_msg }
    end

    describe 'given a nested map with a broken env string (missing newline)', drop: true do
      yaml %(
        jobs:
          include:
            mono:
              4.0.5env: EDITOR=nvim
      )
      it { should serialize_to empty }
      it { should have_msg [:error, :'jobs.include.mono', :invalid_type, expected: :str, actual: :map, value: { :'4.0.5env' => 'EDITOR=nvim' }] }
    end

    describe 'given a seq of maps (with env given as a map)' do
      yaml %(
        jobs:
          include:
            - rvm: 2.3
              env:
                FOO: foo
      )
      it { should serialize_to jobs: { include: [rvm: '2.3', env: [FOO: 'foo']] } }
      it { should_not have_msg }
    end

    describe 'given a seq of maps (with rvm given as a string)' do
      yaml %(
        jobs:
          include:
            - rvm: 2.3
              env: FOO=foo
      )
      it { should serialize_to jobs: { include: [rvm: '2.3', env: [FOO: 'foo']] } }
      it { should_not have_msg }
    end

    describe 'given a seq of maps (with env given as a seq of strings)' do
      yaml %(
        jobs:
          include:
            - rvm: 2.3
              env:
              - FOO=foo
              - BAR=bar
      )
      it { should serialize_to jobs: { include: [rvm: '2.3', env: [{ FOO: 'foo' }, { BAR: 'bar' }]] } }
    end

    describe 'given env.global with a seq of maps', drop: true do
      yaml %(
        jobs:
          include:
            - env:
                global:
                  - FOO: true
      )
      it { should serialize_to jobs: { include: [env: [global: nil]] } }
      it { should have_msg [:error, :'jobs.include.env.global', :invalid_type, expected: :str, actual: :seq, value: [FOO: true]] }
    end

    describe 'given language (str)' do
      yaml %(
        jobs:
          include:
            language: ruby
      )
      it { should serialize_to jobs: { include: [language: 'ruby'] } }
      it { should_not have_msg }
    end

    describe 'given language (seq)' do
      yaml %(
        jobs:
          include:
            language:
            - ruby
      )
      it { should serialize_to jobs: { include: [language: 'ruby'] } }
      it { should have_msg [:warn, :'jobs.include.language', :unexpected_seq, value: 'ruby'] }
    end

    describe 'given language with a typo' do
      yaml %(
        jobs:
          include:
            language: ruby`
      )
      it { should serialize_to jobs: { include: [language: 'ruby'] } }
      it { should have_msg [:warn, :'jobs.include.language', :find_value, original: 'ruby`', value: 'ruby'] }
    end

    describe 'given jdk (str)' do
      yaml %(
        jobs:
          include:
          - language: ruby
            jdk: str
      )
      it { should serialize_to jobs: { include: [language: 'ruby', jdk: 'str'] } }
      it { should_not have_msg }
    end

    describe 'given jdk (seq)' do
      yaml %(
        jobs:
          include:
          - language: ruby
            jdk:
            - str
      )
      it { should serialize_to jobs: { include: [language: 'ruby', jdk: 'str'] } }
      it { should have_msg [:warn, :'jobs.include.jdk', :unexpected_seq, value: 'str'] }
    end

    describe 'given compiler (str)' do
      yaml %(
        jobs:
          include:
          - language: cpp
            compiler: str
      )
      it { should serialize_to jobs: { include: [language: 'cpp', compiler: 'str'] } }
      it { should_not have_msg }
    end

    describe 'given compiler (seq)' do
      yaml %(
        jobs:
          include:
          - language: cpp
            compiler:
            - str
      )
      it { should serialize_to jobs: { include: [language: 'cpp', compiler: 'str'] } }
      it { should have_msg [:warn, :'jobs.include.compiler', :unexpected_seq, value: 'str'] }
    end

    describe 'given licenses' do
      yaml %(
        jobs:
          include:
          - language: android
            android:
              licenses:
                - str
      )
      it { should serialize_to jobs: { include: [language: 'android', android: { licenses: ['str'] }] } }
      it { should_not have_msg }
    end

    describe 'unknown value, with an unsupported key' do
      yaml %(
        jobs:
          include:
            language: node_js - 9
            compiler: gcc
      )
      it { should serialize_to jobs: { include: [language: 'node_js', compiler: 'gcc'] } }
      it { should have_msg [:warn, :'jobs.include.language', :clean_value, original: 'node_js - 9', value: 'node_js'] }
      it { should have_msg [:warn, :'jobs.include.compiler', :unsupported, on_key: 'language', on_value: 'node_js', key: 'compiler', value: 'gcc'] }
    end

    describe 'given a name' do
      yaml %(
        jobs:
          include:
            name: name
      )
      it { should serialize_to jobs: { include: [name: 'name'] } }
      it { should_not have_msg }
    end

    describe 'given duplicate names' do
      yaml %(
        jobs:
          include:
            - name: name
            - name: name
      )
      it { should serialize_to jobs: { include: [{ name: 'name' }, { name: 'name' }] } }
      it { should have_msg [:info, :'jobs.include', :duplicate, values: 'name: name'] }
    end

    describe 'given addons' do
      yaml %(
        jobs:
          include:
            - addons:
                apt: package
      )
      it { should serialize_to jobs: { include: [addons: { apt: { packages: ['package'] } }] } }
      it { should_not have_msg }
    end

    describe 'given branches' do
      yaml %(
        jobs:
          include:
            - branches:
                only: master
      )
      it { should serialize_to jobs: { include: [branches: { only: ['master'] }] } }
      it { should_not have_msg }
    end

    describe 'given a condition' do
      describe 'valid' do
        yaml %(
          jobs:
            include:
              - if: 'branch = master'
        )
        it { should serialize_to jobs: { include: [if: 'branch = master'] } }
        it { should_not have_msg }
      end

      describe 'invalid' do
        yaml %(
          jobs:
            include:
              if: '= foo'
        )
        it { should serialize_to empty }
        it { should have_msg [:error, :'jobs.include.if', :invalid_condition, condition: '= foo'] }
      end
    end

    describe 'given a misplaced env' do
      yaml %(
        jobs:
          include:
            - os: linux
          env:
            - FOO=str
      )
      it { should serialize_to jobs: { include: [os: 'linux'], env: ['FOO=str'] } }
      it { should have_msg [:warn, :jobs, :unknown_key, key: 'env', value: ['FOO=str']] }
    end

    describe 'given a misplaced key' do
      yaml %(
        jobs:
          include:
            env:
              DEBUG: on
      )
      it { should serialize_to jobs: { include: [env: [DEBUG: 'on']] } }
      it { should_not have_msg }
    end

    describe 'given an unknown os' do
      yaml %(
        jobs:
          include:
            - os: unknown
      )
      it { should serialize_to jobs: { include: [os: 'linux'] } }
      it { should have_msg [:warn, :'jobs.include.os', :unknown_default, value: 'unknown', default: 'linux'] }
    end
  end

  [:exclude, :allow_failures].each do |key|
    describe key.to_s do
      describe 'given a map' do
        yaml %(
          jobs:
            #{key}:
              rvm: 2.3
        )
        it { should serialize_to jobs: { key => [rvm: '2.3'] } }
        it { should_not have_msg }
      end

      describe 'given a seq of maps' do
        yaml %(
          jobs:
            #{key}:
              - rvm: 2.3
        )
        it { should serialize_to jobs: { key => [rvm: '2.3'] } }
        it { should_not have_msg }
      end

      describe 'given true', drop: true do
        yaml %(
          jobs:
            #{key}: true
        )
        it { should serialize_to empty }
        it { should have_msg [:error, :"jobs.#{key}", :invalid_type, expected: :map, actual: :bool, value: true] }
      end

      describe 'default language', defaults: true do
        yaml %(
          jobs:
            #{key}:
              rvm: 2.3
        )
        it { should serialize_to language: 'ruby', os: ['linux'], jobs: { key => [rvm: '2.3'] } }
      end

      describe 'given language' do
        yaml %(
          jobs:
            #{key}:
              language: ruby
        )
        it { should serialize_to jobs: { key => [language: 'ruby'] } }
        it { should_not have_msg }
      end

      describe 'env' do
        describe 'given as string' do
          yaml %(
            jobs:
              #{key}:
                env: 'FOO=foo BAR=bar'
          )
          it { should serialize_to jobs: { key => [env: [{ FOO: 'foo', BAR: 'bar' }]] } }
          it { should_not have_msg }
        end

        describe 'given as a seq of strings' do
          yaml %(
            jobs:
              #{key}:
                env:
                  - FOO=foo
                  - BAR=bar
          )
          it { should serialize_to jobs: { key => [env: [{ FOO: 'foo' }, { BAR: 'bar' }]] } }
          it { should_not have_msg }
        end

        describe 'given as a map' do
          yaml %(
            jobs:
              #{key}:
                env:
                  FOO: foo
                  BAR: bar
          )
          it { should serialize_to jobs: { key => [env: [{ FOO: 'foo', BAR: 'bar' }]] } }
          it { should_not have_msg }
        end

        describe 'given as a seq of maps' do
          yaml %(
            jobs:
              #{key}:
                env:
                  - FOO: foo
                  - BAR: bar
          )
          it { should serialize_to jobs: { key => [env: [{ FOO: 'foo' }, { BAR: 'bar' }]] } }
          it { should_not have_msg }
        end
      end

      describe 'given licenses' do
        yaml %(
          jobs:
            #{key}:
            - language: android
              android:
                licenses:
                  - str
        )
        it { should serialize_to jobs: { key => [language: 'android', android: { licenses: ['str'] }] } }
        it { should_not have_msg }
      end

      describe 'given an unsupported key' do
        describe 'language given on root' do
          yaml %(
            language: ruby
            jobs:
              #{key}:
                - rvm: 2.3
                  python: 3.5
          )
          it { should serialize_to language: 'ruby', jobs: { key => [rvm: '2.3', python: '3.5'] } }
          it { should have_msg [:warn, :"jobs.#{key}.python", :unsupported, on_key: 'language', on_value: 'ruby', key: 'python', value: '3.5'] }
        end

        describe "language given on jobs.#{key}" do
          yaml %(
            jobs:
              #{key}:
                - language: ruby
                  rvm: 2.3
                  python: 3.5
          )
          it { should serialize_to jobs: { key => [language: 'ruby', rvm: '2.3', python: '3.5'] } }
          it { should have_msg [:warn, :"jobs.#{key}.python", :unsupported, on_key: 'language', on_value: 'ruby', key: 'python', value: '3.5'] }
        end

        describe 'in separate entries' do
          yaml %(
            language: ruby
            jobs:
              #{key}:
                - rvm: 2.3
                - python: 3.5
          )
          it { should serialize_to language: 'ruby', jobs: { key => [{ rvm: '2.3' }, { python: '3.5' }] } }
          it { should have_msg [:warn, :"jobs.#{key}.python", :unsupported, on_key: 'language', on_value: 'ruby', key: 'python', value: '3.5'] }
        end
      end
    end
  end

  describe 'allow_failures' do
    describe "alias allowed_failures" do
      yaml %(
        jobs:
          allowed_failures:
            rvm: 2.3
      )
      it { should serialize_to jobs: { allow_failures: [rvm: '2.3'] } }
      it { should have_msg [:info, :jobs, :alias_key, alias: 'allowed_failures', key: 'allow_failures'] }
    end

    describe 'allow_failures given a seq of strings (common mistake)', drop: true do
      yaml %(
        jobs:
          allowed_failures:
            - 2.3
      )
      it { should serialize_to empty }
      it { should have_msg [:error, :'jobs.allow_failures', :invalid_type, expected: :map, actual: :str, value: '2.3'] }
    end

    describe 'misplaced on root', v2: true, migrate: true do
      yaml %(
      )
      it { should serialize_to jobs: { allow_failures: [rvm: '2.3'] } }
      it { should have_msg [:warn, :root, :migrate, key: 'allow_failures', to: 'jobs', value: [rvm: '2.3']] }
    end

    describe 'alias allowed_failures, misplaced on root', v2: true, migrate: true do
      yaml %(
        allowed_failures:
          rvm: 2.3
      )
      it { should serialize_to jobs: { allow_failures: [rvm: '2.3'] } }
      it { should have_msg [:warn, :root, :migrate, key: 'allow_failures', to: 'jobs', value: [rvm: '2.3']] }
    end
  end

  describe 'misplaced keys', v2: true, migrate: true do
    yaml %(
      jobs:
        include:
          - apt:
              packages: clang
          - apt:
    )
    it { should serialize_to jobs: { include: [addons: { apt: { packages: ['clang'] } }] } }
    it { should have_msg [:warn, :'jobs.include', :migrate, key: 'apt', to: 'addons', value: { packages: ['clang'] }] }
    it { should have_msg [:warn, :'jobs.include', :migrate, key: 'apt', to: 'addons', value: nil] }
  end

  describe 'duplicate values' do
    yaml %(
      jobs:
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
