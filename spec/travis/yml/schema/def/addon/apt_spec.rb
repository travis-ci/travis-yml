describe Travis::Yml::Schema::Def::Addon::Apt, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:addon][:apt] }
    # subject { described_class.new.definitions[:addon][:apt] }

    xit { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :addon_apt,
        title: 'Addon Apt',
        normal: true,
        anyOf: [
          {
            type: :object,
            properties: {
              packages: {
                '$ref': '#/definitions/type/strs'
              },
              sources: {
                anyOf: [
                  {
                    type: :array,
                    items: {
                      type: :object,
                      properties: {
                        name: {
                          type: :string
                        },
                        sourceline: {
                          type: :string
                        },
                        key_url: {
                          type: :string
                        }
                      },
                      additionalProperties: false,
                      prefix: :name,
                    },
                    normal: true
                  },
                  {
                    type: :object,
                    properties: {
                      name: {
                        type: :string
                      },
                      sourceline: {
                        type: :string
                      },
                      key_url: {
                        type: :string
                      }
                    },
                    additionalProperties: false,
                    prefix: :name,
                  },
                  {
                    type: :array,
                    items: {
                      type: :string
                    }
                  },
                  {
                    type: :string
                  }
                ]
              },
              dist: {
                type: :string
              },
              update: {
                type: :boolean
              }
            },
            additionalProperties: false,
            prefix: :packages,
            keys: {
              packages: {
                aliases: [
                  :package
                ]
              },
              sources: {
                aliases: [
                  :source
                ]
              }
            },
            normal: true,
            changes: [
              {
                change: :enable
              }
            ],
          },
          {
            '$ref': '#/definitions/type/strs'
          },
          {
            type: :boolean
          }
        ]
      )
    end
  end

  describe 'schema' do
    subject { described_class.new.schema }

    it do
      should eq(
        '$ref': '#/definitions/addon/apt'
      )
    end
  end
end
