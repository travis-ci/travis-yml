describe Travis::Yml::Schema::Def::Haxe, 'schema' do
  subject { Travis::Yml.schema[:definitions][:language][:haxe] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :language_haxe,
        title: 'Language Haxe',
        type: :object,
        properties: {
          haxe: {
            '$ref': '#/definitions/type/strs',
            flags: [
              :expand
            ],
            only: {
              language: [
                'haxe'
              ]
            }
          },
          hxml: {
            '$ref': '#/definitions/type/strs',
            only: {
              language: [
                'haxe'
              ]
            }
          },
          neko: {
            type: :string,
            only: {
              language: [
                'haxe'
              ]
            }
          }
        },
        normal: true
    )
  end
end
