describe Travis::Yml::Schema::Def::Addon::Apt, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:addon][:apt] }
    # subject { described_class.new.definitions[:addon][:apt] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :apt,
        title: 'Apt',
        anyOf: [
          {
            type: :object,
            properties: {
              packages: {
                '$ref': '#/definitions/strs'
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
                      }
                    },
                    additionalProperties: false,
                    prefix: :name,
                  },
                  {
                    type: :string
                  }
                ]
              },
              dist: {
                type: :string
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
            normal: true
          },
          {
            '$ref': '#/definitions/strs'
          }
        ]
      )
    end
  end

  # describe 'schema' do
  #   subject { described_class.new.schema }
  #
  #   it do
  #     should eq(
  #       '$ref': '#/definitions/addon/apt'
  #     )
  #   end
  # end
end
