describe Travis::Yml::Schema::Def::Jobs do
  describe 'jobs' do
    subject { Travis::Yml.schema[:definitions][:type][:jobs] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should include(
        '$id': :jobs,
        title: 'Job Matrix',
        summary: 'Build matrix definitions',
        see: kind_of(Hash),
        normal: true,
        anyOf: [
          {
            type: :object,
            properties: {
              include: {
                '$ref': '#/definitions/type/jobs_includes',
                summary: kind_of(String)
              },
              exclude: {
                '$ref': '#/definitions/type/jobs_excludes',
                summary: kind_of(String)
              },
              allow_failures: {
                '$ref': '#/definitions/type/jobs_allow_failures',
                summary: kind_of(String),
                aliases: [
                  :allowed_failures
                ]
              },
              fast_finish: {
                type: :boolean,
                summary: kind_of(String),
                aliases: [
                  :fast_failure
                ]
              }
            },
            additionalProperties: false,
            normal: true,
            aliases: [
              :matrix
            ],
            prefix: {
              key: :include
            },
            see: kind_of(Hash),
          },
          {
            '$ref': '#/definitions/type/jobs_includes'
          }
        ]
      )
    end
  end
end
