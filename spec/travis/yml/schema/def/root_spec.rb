require 'json'

describe Travis::Yml::Schema::Def::Root do
  subject { Travis::Yml.schema }

  # it { puts JSON.pretty_generate(subject) }

  it { should include title: 'JSON schema for Travis CI configuration files' }
  it { should include '$schema': 'http://json-schema.org/draft-04/schema#' }

  describe 'secure' do
    subject { Travis::Yml.schema[:definitions][:type][:secure] }

    it do
      should eq(
        '$id': :secure,
        title: 'Secure',
        anyOf: [
          {
            type: :object,
            properties: {
              secure: {
                type: :string
              }
            },
            additionalProperties: false,
            maxProperties: 1,
            normal: true
          },
          {
            type: :string,
            normal: true
          }
        ]
      )
    end
  end

  describe 'secures' do
    subject { Travis::Yml.schema[:definitions][:type][:secures] }

    it do
      should eq(
        '$id': :secures,
        title: 'Secures',
        anyOf: [
          {
            type: :array,
            items: { '$ref': '#/definitions/type/secure' },
            normal: true
          },
          {
            '$ref': '#/definitions/type/secure'
          }
        ]
      )
    end
  end

  describe 'strs' do
    subject { Travis::Yml.schema[:definitions][:type][:strs] }

    it do
      should eq(
        '$id': :strs,
        'title': 'Strs', # ?
        anyOf: [
          {
            type: :array,
            minItems: 1,
            items: {
              anyOf: [
                { type: :string }
              ]
            },
            normal: true
          },
          {
            type:
            :string
          },
        ]
      )
    end
  end

  describe 'keys' do
    subject { Travis::Yml.schema[:definitions] }

    definitions = {
      type: %i(
        addons
        arch
        archs
        branches
        cache
        compilers
        conditions
        condition
        deploys
        dist
        env
        env_var
        env_vars
        git
        group
        import
        imports
        jdks
        job
        jobs
        jobs_allow_failure
        jobs_allow_failures
        jobs_include
        jobs_includes
        jobs_exclude
        jobs_excludes
        language
        languages
        keys
        notifications
        os
        oss
        osx_images
        perforce_test_path
        secure
        secures
        service
        services
        stack
        stage
        stages
        strs
        sudo
        support
        vault
        version
        virt
        vm
      ),
      addon: %i(
        apt
        artifacts
        browserstack
        code_climate
        coverity_scan
        homebrew
        jwts
        sauce_connect
        snaps
        pkg
        sonarcloud
      ),
      deploy: %i(
        branches
        conditions
        edge
        providers
        anynines
        azure_web_apps
        bintray
        bluemixcloudfoundry
        boxfuse
        cargo
        chef_supermarket
        cloud66
        cloudfiles
        cloudfoundry
        cloudformation
        codedeploy
        convox
        datica
        elasticbeanstalk
        engineyard
        firebase
        flynn
        gae
        gcs
        git_push
        gleis
        hackage
        hephy
        heroku
        lambda
        launchpad
        netlify
        npm
        openshift
        opsworks
        packagecloud
        pages
        puppetforge
        pypi
        releases
        rubygems
        s3
        scalingo
        script
        snap
        surge
        testfairy
        transifex
      ),
      language: %i(
        __amethyst__
        __connie__
        __cookiecat__
        __garnet__
        __onion__
        __opal__
        __sardonyx__
        __stevonnie__
        android
        c
        clojure
        cpp
        crystal
        csharp
        d
        dart
        elixir
        elm
        erlang
        generic
        go
        groovy
        hack
        haskell
        haxe
        java
        julia
        matlab
        nix
        node_js
        objective-c
        perl
        perl6
        php
        python
        r
        ruby
        rust
        scala
        shell
        smalltalk
      ),
      notification: %i(
        campfire
        email
        flowdock
        frequency
        hipchat
        irc
        pushover
        slack
        template
        templates
        webhooks
      )
    }
    #   %i(
    #   secure
    #   secures
    #   strs
    # )

    # it do
    #   p subject[:type].keys.sort
    #   p definitions[:type].sort
    # end

    definitions.each do |namespace, keys|
      it { expect(subject[namespace].keys.sort).to eq keys.sort }
    end
  end

  describe 'root' do
    # it do
    #   should include allOf: [
    #     hash_including(type: :object),
    #     { '$ref': '#/definitions/type/job' }
    #   ]
    # end

    describe 'properties' do
      subject { Travis::Yml.schema[:allOf][0][:properties] }

      # it { puts JSON.pretty_generate(subject) }

      it do
        expect(subject.keys.sort).to eq %i(
          arch
          compiler
          conditions
          dist
          env
          filter_secrets
          import
          jobs
          language
          notifications
          os
          osx_image
          perforce_test_path
          stack
          stages
          sudo
          trace
          vault
          version
          vm
        )
      end

      it { should include arch:           { '$ref': '#/definitions/type/archs', flags: [:expand] } }
      it { should include compiler:       { '$ref': '#/definitions/type/compilers', flags: [:expand] } }
      it { should include conditions:     { '$ref': '#/definitions/type/conditions' } }
      it { should include dist:           { '$ref': '#/definitions/type/dist', defaults: [{ value: 'xenial', only: { os: ['linux', 'linux-ppc64le'] } }] } }
      it { should include env:            { '$ref': '#/definitions/type/env' } }
      it { should include import:         { '$ref': '#/definitions/type/imports' } }
      # it { should include language:       { '$ref': '#/definitions/type/language' } }
      it { should include jobs:           { '$ref': '#/definitions/type/jobs', aliases: [:matrix] } }
      it { should include notifications:  { '$ref': '#/definitions/type/notifications' } }
      it { should include os:             { '$ref': '#/definitions/type/oss', flags: [:expand], defaults: [{ value: 'linux', except: { language: ['objective-c'] } }, { value: 'osx', only: { language: ['objective-c'] } }] } }

      it { should include stack:          { '$ref': '#/definitions/type/stack' } }
      it { should include stages:         { '$ref': '#/definitions/type/stages' } }
      it { should include sudo:           { '$ref': '#/definitions/type/sudo' } }
      it { should include version:        { '$ref': '#/definitions/type/version' } }
      it { should include filter_secrets: { type: :boolean, flags: [:internal], summary: 'Whether to filter secrets from the log output' } }
      it { should include trace:          { type: :boolean, flags: [:internal], summary: 'Whether to trace the build script' } }
    end
  end
end
