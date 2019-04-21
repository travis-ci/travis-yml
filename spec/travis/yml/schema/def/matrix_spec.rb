describe Travis::Yml::Schema::Def::Matrix, 'structure' do
  describe 'definitions' do
    describe 'matrix' do
      subject { Travis::Yml.schema[:definitions][:type][:matrix] }

      # it { puts JSON.pretty_generate(subject) }

      it do
        should eq(
          '$id': :matrix,
          title: 'Matrix',
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
                  '$ref': '#/definitions/type/matrix_entries'
                },
                fast_finish: {
                  type: :boolean
                }
              },
              additionalProperties: false,
              normal: true,
              prefix: :include,
              keys: {
                allow_failures: {
                  aliases: [
                    :allowed_failures
                  ]
                },
                fast_finish: {
                  aliases: [
                    :fast_failure
                  ]
                }
              }
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
                '$ref': '#/definitions/type/matrix_entry'
              },
              normal: true
            },
            {
              '$ref': '#/definitions/type/matrix_entry'
            }
          ]
        )
      end
    end

    describe 'matrix_entry' do
      subject { Travis::Yml.schema[:definitions][:type][:matrix_entry] }

      # it { puts JSON.pretty_generate(subject) }

      it do
        should include allOf: [
          hash_including(type: :object),
          { '$ref': '#/definitions/type/job' }
        ]
      end

      describe 'properties' do
        subject { super()[:allOf][0][:properties] }

        it { should include name: { type: :string } }
        it { should include language: { '$ref': '#/definitions/type/language' } }
        it { should include os: { '$ref': '#/definitions/type/os' } }
        it { should include arch: { '$ref': '#/definitions/type/arch' } }
        it { should include dist: { '$ref': '#/definitions/type/dist' } }
        it { should include sudo: { '$ref': '#/definitions/type/sudo' } }
        it { should include env: { '$ref': '#/definitions/type/env_vars' } }
        it { should include compiler: { '$ref': '#/definitions/type/compilers' } }
        it { should include stage: { '$ref': '#/definitions/type/stage' } }
      end
    end
  end

  describe 'schema' do
    subject { described_class.new.schema }

    it do
      should eq(
        '$ref': '#/definitions/type/matrix'
      )
    end
  end
end
