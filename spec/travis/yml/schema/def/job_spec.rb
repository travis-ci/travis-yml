require 'json'

describe Travis::Yml::Schema::Def::Job, 'structure' do
    # it { puts JSON.pretty_generate(subject) }

  describe 'export' do
    subject { Travis::Yml.schema[:definitions][:type][:job] }

    it do
      should include allOf: [
        hash_including(type: :object),
        { '$ref': '#/definitions/type/languages' }
      ]
    end

    describe 'properties' do
      subject { Travis::Yml.schema[:definitions][:type][:job][:allOf][0] }

      it do
        should eq(
          type: :object,
          properties: {
            group: {
              '$ref': '#/definitions/type/group'
            },
            osx_image: {
              type: :string,
              flags: [
                :edge
              ],
            },
            services: {
              '$ref': '#/definitions/type/services'
            },
            addons: {
              '$ref': '#/definitions/type/addons'
            },
            branches: {
              '$ref': '#/definitions/type/branches'
            },
            cache: {
              '$ref': '#/definitions/type/cache'
            },
            deploy: {
              '$ref': '#/definitions/type/deploys'
            },
            git: {
              '$ref': '#/definitions/type/git'
            },
            source_key: {
              '$ref': '#/definitions/secure'
            },
            if: {
              type: :string
            },
            before_install: {
              '$ref': '#/definitions/strs'
            },
            install: {
              '$ref': '#/definitions/strs'
            },
            after_install: {
              '$ref': '#/definitions/strs'
            },
            before_script: {
              '$ref': '#/definitions/strs'
            },
            script: {
              '$ref': '#/definitions/strs'
            },
            after_script: {
              '$ref': '#/definitions/strs'
            },
            after_result: {
              '$ref': '#/definitions/strs'
            },
            after_success: {
              '$ref': '#/definitions/strs'
            },
            after_failure: {
              '$ref': '#/definitions/strs'
            },
            before_deploy: {
              '$ref': '#/definitions/strs'
            },
            after_deploy: {
              '$ref': '#/definitions/strs'
            },
            before_cache: {
              '$ref': '#/definitions/strs'
            }
          },
          keys: {
            osx_image: {
              only: {
                os: [
                  'osx'
                ]
              }
            },
            branches: {
              aliases: [
                :branch
              ]
            }
          }
        )
      end
    end

    describe 'stages' do
      stages = %i(
        before_install
        install
        after_install
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

      properties = stages + %i(
        addons
        branches
        cache
        deploy
        git
        group
        if
        osx_image
        services
        source_key
      )

      subject { Travis::Yml.schema[:definitions][:type][:job][:allOf][0][:properties] }

      it { expect(subject.keys.sort).to eq properties.sort }

      stages.each { |stage| it { should include stage => { '$ref': '#/definitions/strs' } } }
    end
  end

  # describe 'schema' do
  #   subject { described_class.new.schema }
  #
  #   it do
  #     should eq(
  #       '$ref': '#/definitions/type/job'
  #     )
  #   end
  # end
end
