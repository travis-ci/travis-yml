describe Travis::Yml::Schema::Def::Haxe, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:haxe] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :language_haxe,
        title: 'Language Haxe',
        type: :object,
        properties: {
          haxe: {
            '$ref': '#/definitions/type/strs'
          },
          hxml: {
            '$ref': '#/definitions/type/strs'
          },
          neko: {
            type: :string
          }
        },
        normal: true,
        keys: {
          haxe: {
            only: {
              language: [
                'haxe'
              ]
            }
          },
          hxml: {
            only: {
              language: [
                'haxe'
              ]
            }
          },
          neko: {
            only: {
              language: [
                'haxe'
              ]
            }
          }
        }
      )
    end
  end
end
