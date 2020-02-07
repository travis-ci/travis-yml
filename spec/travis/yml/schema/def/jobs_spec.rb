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
                '$ref': '#/definitions/type/jobs_entries',
                summary: kind_of(String)
              },
              exclude: {
                '$ref': '#/definitions/type/jobs_entries',
                summary: kind_of(String)
              },
              allow_failures: {
                '$ref': '#/definitions/type/jobs_entries',
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
            '$ref': '#/definitions/type/jobs_entries'
          }
        ]
      )
    end
  end

  describe 'jobs_entries' do
    subject { Travis::Yml.schema[:definitions][:type][:jobs_entries] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :jobs_entries,
        title: 'Job Matrix Entries',
        anyOf: [
          {
            type: :array,
            items: {
              '$ref': '#/definitions/type/jobs_entry',
            },
            normal: true,
          },
          {
            '$ref': '#/definitions/type/jobs_entry',
          }
        ]
      )
    end
  end

  describe 'jobs_entry' do
    subject { Travis::Yml.schema[:definitions][:type][:jobs_entry][:allOf][0][:properties] }

    # it { puts JSON.pretty_generate(subject) }

    it { should include name: { type: :string, flags: [:unique] } }
    # it { should include language: { '$ref': '#/definitions/type/language' } }
    it { should include os: { '$ref': '#/definitions/type/os' } }
    it { should include arch: { '$ref': '#/definitions/type/arch' } }
    it { should include dist: { '$ref': '#/definitions/type/dist' } }
    it { should include sudo: { '$ref': '#/definitions/type/sudo' } }
    it { should include env: { '$ref': '#/definitions/type/env_vars' } }
    it { should include compiler: { type: :string, only: { language: ['c', 'cpp'] }, example: 'gcc' } }
    it { should include stage: { type: :string } }
  end
end
