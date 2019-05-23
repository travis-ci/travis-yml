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
        if: {
          '$ref': '#/definitions/type/condition'
        },
        before_install: {
          '$ref': '#/definitions/type/strs',
          summary: 'Scripts to run before the install stage'
        },
        install: {
          '$ref': '#/definitions/type/strs',
          summary: 'Scripts to run at the install stage'
        },
        after_install: {
          '$ref': '#/definitions/type/strs',
          summary: 'Scripts to run after the install stage'
        },
        before_script: {
          '$ref': '#/definitions/type/strs',
          summary: 'Scripts to run before the script stage'
        },
        script: {
          '$ref': '#/definitions/type/strs',
          summary: 'Scripts to run at the script stage'
        },
        after_success: {
          '$ref': '#/definitions/type/strs',
          summary: 'Scripts to run after a successful script stage'
        },
        after_failure: {
          '$ref': '#/definitions/type/strs',
          summary: 'Scripts to run after a failing script stage'
        },
        after_script: {
          '$ref': '#/definitions/type/strs',
          summary: 'Scripts to run after the script stage'
        },
        before_cache: {
          '$ref': '#/definitions/type/strs',
          summary: 'Scripts to run before storing a build cache'
        },
        before_deploy: {
          '$ref': '#/definitions/type/strs',
          summary: 'Scripts to run before the deploy stage'
        },
        after_deploy: {
          '$ref': '#/definitions/type/strs',
          summary: 'Scripts to run after the deploy stage'
        }
      },
    )
  end
end
