describe Travis::Yml::Schema::Def::Matrix do
  describe 'matrix' do
    subject { Travis::Yml.schema[:definitions][:type][:matrix] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :matrix,
        title: 'Matrix',
        summary: 'Build matrix definitions',
        normal: true,
        anyOf: [
          {
            type: :object,
            properties: {
              include: {
                '$ref': '#/definitions/type/matrix_entries'
              },
              exclude: {
                '$ref': '#/definitions/type/matrix_entries'
              },
              allow_failures: {
                '$ref': '#/definitions/type/matrix_entries',
                aliases: [
                  :allowed_failures
                ]
              },
              fast_finish: {
                type: :boolean,
                aliases: [
                  :fast_failure
                ]
              }
            },
            additionalProperties: false,
            normal: true,
            aliases: [
              :jobs
            ],
            prefix: {
              key: :include
            },
          },
          {
            '$ref': '#/definitions/type/matrix_entries'
          }
        ]
      )
    end
  end

  describe 'matrix_entries' do
    subject { Travis::Yml.schema[:definitions][:type][:matrix_entries] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :matrix_entries,
        title: 'Matrix Entries',
        anyOf: [
          {
            type: :array,
            items: {
              '$ref': '#/definitions/type/matrix_entry',
            },
            normal: true,
          },
          {
            '$ref': '#/definitions/type/matrix_entry',
          }
        ]
      )
    end
  end

  describe 'matrix_entry' do
    subject { Travis::Yml.schema[:definitions][:type][:matrix_entry][:allOf][0][:properties] }

    # it { puts JSON.pretty_generate(subject) }

    it { should include name: { type: :string, flags: [:unique] } }
    # it { should include language: { '$ref': '#/definitions/type/language' } }
    it { should include os: { '$ref': '#/definitions/type/os' } }
    it { should include arch: { '$ref': '#/definitions/type/arch' } }
    it { should include dist: { '$ref': '#/definitions/type/dist' } }
    it { should include sudo: { '$ref': '#/definitions/type/sudo' } }
    it { should include env: { '$ref': '#/definitions/type/env_vars' } }
    it { should include compiler: { type: :string, only: { language: ['c', 'cpp'] } } }
    it { should include stage: { type: :string } }
  end
end
