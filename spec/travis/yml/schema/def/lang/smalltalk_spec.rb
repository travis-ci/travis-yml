describe Travis::Yml::Schema::Def::Smalltalk, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:smalltalk] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :smalltalk,
        title: 'Smalltalk',
        type: :object,
        properties: {
          smalltalk: {
            '$ref': '#/definitions/strs'
          },
          smalltalk_config: {
            '$ref': '#/definitions/strs'
          },
          smalltalk_edge: {
            type: :boolean
          }
        },
        keys: {
          smalltalk: {
            only: {
              language: [
                'smalltalk'
              ]
            }
          },
          smalltalk_config: {
            only: {
              language: [
                'smalltalk'
              ]
            }
          },
          smalltalk_edge: {
            only: {
              language: [
                'smalltalk'
              ]
            }
          }
        },
        normal: true
      )
    end
  end

  describe 'schema' do
    subject { described_class.new.schema }

    it do
      should eq(
        '$ref': '#/definitions/language/smalltalk'
      )
    end
  end
end
