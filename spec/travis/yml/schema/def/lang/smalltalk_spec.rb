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
        normal: true,
        only: {
          smalltalk: {
            language: [
              'smalltalk'
            ]
          },
          smalltalk_config: {
            language: [
              'smalltalk'
            ]
          },
          smalltalk_edge: {
            language: [
              'smalltalk'
            ]
          }
        }
      )
    end
  end

  # describe 'schema' do
  #   subject { described_class.new.schema }
  #
  #   it do
  #     should eq(
  #       '$ref': '#/definitions/language/smalltalk'
  #     )
  #   end
  # end
end
