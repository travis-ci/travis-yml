require 'json'

describe Travis::Yml::Schema::Def::Root, 'structure' do
  subject { Travis::Yml.schema }

  # it { puts JSON.pretty_generate(subject) }

  it { should include title: 'JSON schema for Travis CI configuration files' }
  it { should include '$schema': 'http://json-schema.org/draft-04/schema#' }

  describe 'definitions' do
    describe 'secure' do
      subject { Travis::Yml.schema[:definitions][:secure] }

      it do
        should eq(
          '$id': :secure,
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
      subject { Travis::Yml.schema[:definitions][:secures] }

      it do
        should eq(
          '$id': :secures,
          anyOf: [
            {
              type: :array,
              items: { '$ref': '#/definitions/secure' },
              normal: true
            },
            {
              '$ref': '#/definitions/secure'
            }
          ]
        )
      end
    end

    describe 'strs' do
      subject { Travis::Yml.schema[:definitions][:strs] }

      it do
        should eq(
          '$id': :strs,
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
          app
          arch
          archs
          branches
          cache
          compilers
          conditions
          deploy_branches
          deploy_conditions
          deploy_edge
          deploys
          dist
          env
          env_var
          env_vars
          git
          group
          import
          imports
          job
          language
          languages
          matrix
          matrix_entries
          matrix_entry
          notifications
          notification_frequency
          os
          oss
          service
          services
          stack
          stage
          stages
          sudo
          version
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
        ),
        deploy: %i(
          anynines
          appfog
          atlas
          azure_web_apps
          bintray
          bitballoon
          bluemixcf
          boxfuse
          catalyze
          chef_supermarket
          cloud66
          cloudcontrol
          cloudfiles
          cloudfoundry
          codedeploy
          deis
          divshot
          elasticbeanstalk
          engineyard
          firebase
          gae
          gcs
          hackage
          heroku
          lambda
          launchpad
          modulus
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
          surge
          testfairy
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
          go
          groovy
          haskell
          haxe
          java
          julia
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
          hipchat
          irc
          pushover
          slack
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
  end

  describe 'root' do
    it do
      should include allOf: [
        hash_including(type: :object),
        { '$ref': '#/definitions/type/job' }
      ]
    end

    describe 'properties' do
      subject { Travis::Yml.schema[:allOf][0][:properties] }

      it do
        expect(subject.keys.sort).to eq %i(
          arch
          compiler
          conditions
          dist
          env
          filter_secrets
          import
          language
          matrix
          notifications
          os
          stack
          stages
          sudo
          trace
          version
        )
      end

      it { should include arch:           { '$ref': '#/definitions/type/archs' } }
      it { should include compiler:       { '$ref': '#/definitions/type/compilers' } }
      it { should include conditions:     { '$ref': '#/definitions/type/conditions' } }
      it { should include dist:           { '$ref': '#/definitions/type/dist' } }
      it { should include env:            { '$ref': '#/definitions/type/env' } }
      it { should include import:         { '$ref': '#/definitions/type/imports' } }
      it { should include language:       { '$ref': '#/definitions/type/language' } }
      it { should include matrix:         { '$ref': '#/definitions/type/matrix' } }
      it { should include notifications:  { '$ref': '#/definitions/type/notifications' } }
      it { should include os:             { '$ref': '#/definitions/type/oss' } }
      it { should include stack:          { '$ref': '#/definitions/type/stack' } }
      it { should include stages:         { '$ref': '#/definitions/type/stages' } }
      it { should include sudo:           { '$ref': '#/definitions/type/sudo' } }
      it { should include version:        { '$ref': '#/definitions/type/version' } }
      it { should include filter_secrets: { type: :boolean } }
      it { should include trace:          { type: :boolean } }
    end
  end
end
