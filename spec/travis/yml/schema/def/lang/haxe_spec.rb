describe Travis::Yml::Schema::Def::Haxe do
  subject { Travis::Yml.schema[:definitions][:language][:haxe] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should include(
      '$id': :haxe,
        title: 'Haxe',
        summary: instance_of(String),
        see: instance_of(Hash),
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
