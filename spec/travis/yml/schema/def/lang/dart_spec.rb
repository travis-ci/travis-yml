describe Travis::Yml::Schema::Def::Dart, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:dart] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :language_dart,
        title: 'Language Dart',
        type: :object,
        properties: {
          dart: {
            '$ref': '#/definitions/strs'
          },
          with_content_shell: {
            type: :boolean
          }
        },
        normal: true,
        keys: {
          dart: {
            only: {
              language: [
                'dart'
              ]
            }
          },
          with_content_shell: {
            only: {
              language: [
                'dart'
              ]
            }
          }
        }
      )
    end
  end
end
