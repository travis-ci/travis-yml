describe Travis::Yml, 'deploy' do
  subject { described_class.apply(parse(yaml), opts) }

  describe 'given true', drop: true do
    yaml %(
      deploy: true
    )
    it { should serialize_to empty }
    it { should have_msg [:error, :deploy, :invalid_type, expected: :map, actual: :bool, value: true] }
  end

  describe 'given nil' do
    yaml %(
      deploy:
    )
    it { should serialize_to empty }
    it { should_not have_msg }
  end

  describe 'given a string' do
    yaml %(
      deploy: heroku
    )
    it { should serialize_to deploy: [provider: 'heroku'] }
    it { should_not have_msg }
  end

  describe 'given a map' do
    yaml %(
      deploy:
        provider: heroku
    )
    it { should serialize_to deploy: [provider: 'heroku'] }
    it { should_not have_msg }
  end

  describe 'typo in the provider' do
    yaml %(
      deploy:
        - provider: heruko
    )
    it { should serialize_to deploy: [provider: 'heroku'] }
    it { should have_msg [:warn, :'deploy.provider', :find_value, original: 'heruko', value: 'heroku'] }
  end

  describe 'unknown provider' do
    yaml %(
      deploy:
        - provider: unknown
    )
    it { should serialize_to deploy: [provider: 'unknown'] }
    it { should have_msg [:error, :'deploy.provider', :unknown_value, value: 'unknown'] }
  end

  describe 'missing provider', defaults: true do
    yaml %(
      deploy:
        - unknown: unknown
    )
    it { should serialize_to language: 'ruby', os: ['linux'], deploy: [unknown: 'unknown'] }
    it { should have_msg [:error, :'deploy', :required, key: 'provider'] }
  end

  describe 'invalid type on provider', drop: true do
    yaml %(
      deploy:
        provider:
          provider: heroku
    )
    it { should serialize_to empty }
    it { should have_msg [:error, :'deploy.provider', :invalid_type, expected: :str, actual: :map, value: { provider: 'heroku' }] }
  end

  describe 'given a map' do
    describe 'with a provider' do
      yaml %(
        deploy:
          provider: heroku
      )
      it { should serialize_to deploy: [provider: 'heroku'] }
    end

    describe 'with a missing provider', defaults: true do
      yaml %(
        deploy:
          - strategy: git
      )
      it { should serialize_to language: 'ruby', os: ['linux'], deploy: [strategy: 'git'] }
      it { should have_msg [:error, :'deploy', :required, key: 'provider'] }
    end

    # TODO check if we really need :heroku to be non-strict
    describe 'with extra data (string)' do
      yaml %(
        deploy:
          provider: heroku
          foo: foo
      )
      it { should serialize_to deploy: [provider: 'heroku', foo: 'foo'] }
    end

    describe 'with extra data (map)' do
      yaml %(
        deploy:
          provider: heroku
          foo:
            bar: baz
      )
      it { should serialize_to deploy: [provider: 'heroku', foo: { bar: 'baz' }] }
    end

    describe 'with a secure string' do
      yaml %(
        deploy:
          provider: heroku
          api_key:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'heroku', api_key: { secure: 'secure' }] }
    end
  end

  describe 'given a seq' do
    describe 'with a provider' do
      yaml %(
        deploy:
          - provider: heroku
          - provider: s3
      )
      it { should serialize_to deploy: [{ provider: 'heroku' }, { provider: 's3' } ] }
    end

    describe 'with extra data (string)' do
      yaml %(
        deploy:
          - provider: heroku
            foo: bar
      )
      it { should serialize_to deploy: [{ provider: 'heroku', foo: 'bar' }] }
    end

    describe 'with extra data (map)' do
      yaml %(
        deploy:
          - provider: heroku
            foo:
              bar: baz
      )
      it { should serialize_to deploy: [{ provider: 'heroku', foo: { bar: 'baz' } }] }
    end

    describe 'with a secure string' do
      yaml %(
        deploy:
          - provider: heroku
            api_key:
              secure: secure
      )
      it { should serialize_to deploy: [provider: 'heroku', api_key: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'conditions' do
    describe 'given a string' do
      yaml %(
        deploy:
          provider: heroku
          on: master
      )
      it { should serialize_to deploy: [provider: 'heroku', on: { branch: ['master'] }] }
      it { should_not have_msg }
    end

    describe 'given a map' do
      describe 'repo' do
        yaml %(
          deploy:
            provider: heroku
            on:
              repo: foo/bar
        )
        it { should serialize_to deploy: [provider: 'heroku', on: { repo: 'foo/bar' }] }
        it { should_not have_msg }
      end

      describe 'branch' do
        yaml %(
          deploy:
            provider: heroku
            on:
              branch: master
        )
        it { should serialize_to deploy: [provider: 'heroku', on: { branch: ['master'] }] }
        it { should_not have_msg }
      end

      describe 'branch with an unknown key' do
        yaml %(
          deploy:
            provider: heroku
            script: str
            on:
              branch: master
        )
        it { should serialize_to deploy: [provider: 'heroku', script: 'str', on: { branch: ['master'] }] }
        it { should have_msg [:warn, :deploy, :unknown_key, key: 'script', value: 'str', provider: 'heroku'] }
      end

      describe 'repo' do
        yaml %(
          deploy:
            provider: heroku
            on:
              repo: str
        )
        it { should serialize_to deploy: [provider: 'heroku', on: { repo: 'str' }] }
        it { should_not have_msg }
      end

      describe 'condition (given a str)' do
        yaml %(
          deploy:
            provider: heroku
            on:
              condition: str
        )
        it { should serialize_to deploy: [provider: 'heroku', on: { condition: ['str'] }] }
        it { should_not have_msg }
      end

      describe 'condition (given a seq)' do
        yaml %(
          deploy:
            provider: heroku
            on:
              condition:
                - str
        )
        it { should serialize_to deploy: [provider: 'heroku', on: { condition: ['str'] }] }
        it { should_not have_msg }
      end

      describe 'all_branches' do
        yaml %(
          deploy:
            provider: heroku
            on:
              all_branches: true
        )
        it { should serialize_to deploy: [provider: 'heroku', on: { all_branches: true }] }
        it { should_not have_msg }
      end

      describe 'tags (given true)' do
        yaml %(
          deploy:
            provider: heroku
            on:
              tags: true
        )
        it { should serialize_to deploy: [provider: 'heroku', on: { tags: true }] }
        it { should_not have_msg }
      end

      describe 'tags (given a str)' do
        yaml %(
          deploy:
            provider: heroku
            on:
              tags: str
        )
        it { should serialize_to deploy: [provider: 'heroku', on: { tags: 'str' }] }
        it { should have_msg [:error, :'deploy.on.tags', :invalid_type, expected: :bool, actual: :str, value: 'str'] }
      end

      describe 'language specific key rvm' do
        yaml %(
          deploy:
            provider: heroku
            on:
              rvm: 2.3.1
        )
        it { should serialize_to deploy: [provider: 'heroku', on: { rvm: '2.3.1' }] }
        it { should_not have_msg }
      end

      describe 'language specific key ruby (alias)' do
        yaml %(
          deploy:
            provider: heroku
            on:
              ruby: 2.3.1
        )
        it { should serialize_to deploy: [provider: 'heroku', on: { rvm: '2.3.1' }] }
        it { should have_msg [:info, :'deploy.on', :alias_key, alias: 'ruby', key: 'rvm'] }
      end

      describe 'language specific key python on ruby' do
        yaml %(
          language: ruby
          deploy:
            provider: heroku
            on:
              python: 2.7
        )
        it { should serialize_to language: 'ruby', deploy: [provider: 'heroku', on: { python: '2.7' }] }
        it { should have_msg [:warn, :'deploy.on.python', :unsupported, on_key: 'language', on_value: 'ruby', key: 'python', value: '2.7'] }
      end

      describe 'unknown key' do
        yaml %(
          language: ruby
          deploy:
            provider: heroku
            on:
              unknown: str
        )
        it { should serialize_to language: 'ruby', deploy: [provider: 'heroku', on: { unknown: 'str' }] }
        it { should have_msg [:warn, :'deploy.on', :unknown_key, key: 'unknown', value: 'str'] }
      end

      describe 'alias true' do
        yaml %(
          deploy:
            provider: heroku
            true:
              repo: str
        )
        it { should serialize_to deploy: [provider: 'heroku', on: { repo: 'str' }] }
        it { should have_msg [:info, :deploy, :alias_key, alias: 'true', key: 'on', provider: 'heroku'] }
        xit { should have_msg [:warn, :'deploy.on', :deprecated_key, key: 'on'] }
      end
    end

    describe 'branch specific option hashes (holy shit. example for a valid hash from travis-build)' do
      yaml %(
        deploy:
          - provider: heroku
            on:
              branch:
                production:
                  bucket: production_branch
      )
      xit { should serialize_to deploy: [provider: 'heroku', on: { branch: { production: { bucket: 'production_branch' } } }] }
      xit { should have_msg [:warn, :'deploy.on.branch', :deprecated, deprecation: :branch_specific_option_hash] }
    end

    describe 'migrating :tags, with :tags already given', v2: true, migrate: true do
      yaml %(
        deploy:
          provider: releases
          tags: true
          on:
            tags: true
      )
      # not possible because deploy is not strict?
      it { should have_msg [:warn, :deploy, :migrate, key: 'tags', to: 'on', value: true] }
    end
  end

  describe 'allow_failure' do
    yaml %(
      deploy:
        provider: heroku
        allow_failure: true
    )
    it { should serialize_to deploy: [provider: 'heroku', allow_failure: true] }
    it { should_not have_msg }
  end

  describe 'app and condition' do
    yaml %(
      deploy:
        - provider: heroku
          app:
            master: production
            dev: staging
          on:
            branch: master
    )
    it { should serialize_to deploy: [provider: 'heroku', app: { master: 'production', dev: 'staging' }, on: { branch: ['master'] }] }
    it { should_not have_msg }
  end

  describe 'edge' do
    describe 'given a bool' do
      yaml %(
        deploy:
          provider: heroku
          edge: true
      )
      it { should serialize_to deploy: [provider: 'heroku', edge: true] }
    end

    describe 'given a map' do
      yaml %(
        deploy:
          provider: heroku
          edge:
            source: source
            branch: branch
      )
      it { should serialize_to deploy: [provider: 'heroku', edge: { source: 'source', branch: 'branch' }] }
    end
  end

  describe 'run' do
    describe 'given a seq' do
      yaml %(
        deploy:
          provider: heroku
          run:
          - ./cmd
      )
      it { should serialize_to deploy: [provider: 'heroku', run: ['./cmd']] }
      it { should_not have_msg }
    end

    describe 'given a str' do
      yaml %(
        deploy:
          provider: heroku
          run: ./cmd
      )
      it { should serialize_to deploy: [provider: 'heroku', run: ['./cmd']] }
      it { should_not have_msg }
    end
  end

  # kinda hard to support if we want strict structure on deploy keys
  describe 'option specific branch hashes (deprecated, according to travis-build)' do
    yaml %(
      deploy:
        - provider: heroku
          run:
            production: production
    )
    xit { should serialize_to deploy: [provider: 'heroku', run: { production: 'production' }] }
    xit { should have_msg [:warn, :'deploy.run', :deprecated, given: :run, info: :branch_specific_option_hash] }
  end

  describe 'branches.only' do
    yaml %(
      deploy:
        - provider: heroku
          branches:
            only:
              - master
    )
    it { should serialize_to deploy: [provider: 'heroku', branches: { only: ['master'] }] }
    it { should have_msg [:warn, :deploy, :unknown_key, key: 'branches', value: { only: ['master'] }, provider: 'heroku'] }
  end

  describe 'misplaced keys', v2: true, migrate: true do
    yaml %(
      deploy:
        edge: true
        provider: heroku
        api_key: api_key
    )
    it { should serialize_to deploy: [provider: 'heroku', edge: true, api_key: 'api_key'] }
    it { should have_msg [:warn, :root, :migrate, key: 'provider', to: 'deploy', value: 'heroku'] }
    it { should have_msg [:warn, :root, :migrate, key: 'api_key', to: 'deploy', value: 'api_key'] }
  end

  describe 'misplaced keys (2)', v2: true, migrate: true do
    yaml %(
      deploy:
        edge: true
      provider: heroku
      api_key: api_key
    )
    it { should serialize_to deploy: [provider: 'heroku', edge: true, api_key: 'api_key'] }
    it { should have_msg [:warn, :root, :migrate, key: 'provider', to: 'deploy', value: 'heroku'] }
    it { should have_msg [:warn, :root, :migrate, key: 'api_key', to: 'deploy', value: 'api_key'] }
  end

  describe 'misplaced key that would result in an invalid node if migrated' do
    yaml %(
      file: file
    )
    it { should serialize_to file: 'file' }
    it { should have_msg [:warn, :root, :unknown_key, key: 'file', value: 'file'] }
  end
end
