require 'json'

describe Travis::Yml::Schema::Def::Job do
  subject { Travis::Yml.schema[:definitions][:type][:job] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :job,
      title: 'Job',
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
          only: {
            os: [
              'osx'
            ]
          }
        },
        services: {
          '$ref': '#/definitions/type/services'
        },
        addons: {
          '$ref': '#/definitions/type/addons'
        },
        branches: {
          '$ref': '#/definitions/type/branches',
          aliases: [
            :branch
          ]
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
          '$ref': '#/definitions/type/secure'
        },
        if: {
          type: :string
        },
        before_install: {
          '$ref': '#/definitions/type/strs'
        },
        install: {
          '$ref': '#/definitions/type/strs'
        },
        after_install: {
          '$ref': '#/definitions/type/strs'
        },
        before_script: {
          '$ref': '#/definitions/type/strs'
        },
        script: {
          '$ref': '#/definitions/type/strs'
        },
        after_script: {
          '$ref': '#/definitions/type/strs'
        },
        after_result: {
          '$ref': '#/definitions/type/strs'
        },
        after_success: {
          '$ref': '#/definitions/type/strs'
        },
        after_failure: {
          '$ref': '#/definitions/type/strs'
        },
        before_deploy: {
          '$ref': '#/definitions/type/strs'
        },
        after_deploy: {
          '$ref': '#/definitions/type/strs'
        },
        before_cache: {
          '$ref': '#/definitions/type/strs'
        }
      },
    )
  end
end
