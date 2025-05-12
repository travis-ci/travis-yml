describe Travis::Yml::Schema::Def::Jobs do
  describe 'jobs_excludes' do
    subject { Travis::Yml.schema[:definitions][:type][:jobs_excludes] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :jobs_excludes,
        title: 'Job Matrix Excludes',
        anyOf: [
          {
            type: :array,
            items: {
              '$ref': '#/definitions/type/jobs_exclude',
            },
            normal: true,
          },
          {
            '$ref': '#/definitions/type/jobs_exclude',
          }
        ]
      )
    end
  end

  describe 'jobs_exclude' do
    subject { Travis::Yml.schema[:definitions][:type][:jobs_exclude][:allOf][0][:properties] }

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
        vm: {
          '$ref': '#/definitions/type/vm'
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
        name: {
          type: :string,
          flags: [
            :unique
          ]
        },
        stage: {
          type: :string
        },
        keep_netrc: {
          '$ref': '#/definitions/type/keep_netrc'
        }
      )
    end
  end
end
