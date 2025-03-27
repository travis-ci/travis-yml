describe Travis::Yml::Schema::Def::Jobs do
  describe 'jobs_allow_failures' do
    subject { Travis::Yml.schema[:definitions][:type][:jobs_allow_failures] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :jobs_allow_failures,
        title: 'Job Matrix Allow Failures',
        anyOf: [
          {
            type: :array,
            items: {
              '$ref': '#/definitions/type/jobs_allow_failure',
            },
            normal: true,
          },
          {
            '$ref': '#/definitions/type/jobs_allow_failure',
          }
        ]
      )
    end
  end

  describe 'jobs_allow_failure' do
    subject { Travis::Yml.schema[:definitions][:type][:jobs_allow_failure][:allOf][0][:properties] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        language: {
          '$ref': '#/definitions/type/language'
        },
        os: {
          '$ref': '#/definitions/type/os'
        },
        dist: {
          '$ref': '#/definitions/type/dist'
        },
        arch: {
          '$ref': '#/definitions/type/arch'
        },
        osx_image: {
          type: :string,
          summary: 'OSX image to use for the build environment',
          only: {
            os: [
              'osx'
            ]
          }
        },
        sudo: {
          '$ref': '#/definitions/type/sudo'
        },
        env: {
          '$ref': '#/definitions/type/env_vars'
        },
        compiler: {
          type: :string,
          example: 'gcc',
          only: {
            language: [
              'c',
              'cpp'
            ]
          }
        },
        branches: {
          '$ref': '#/definitions/type/branches'
        },
        vm: {
          '$ref': '#/definitions/type/vm'
        },
        name: {
          type: :string,
          flags: [
            :unique
          ]
        },
        stage: {
          type: :string
        },
        branch: {
          type: :string,
          deprecated: 'use conditional allow_failures using :if'
        },
        keep_netrc: {
          '$ref': '#/definitions/type/keep_netrc'
        }
      )
    end
  end
end
