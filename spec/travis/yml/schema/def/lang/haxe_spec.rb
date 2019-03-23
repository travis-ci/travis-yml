describe Travis::Yml::Schema::Def::Haxe, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:haxe] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :haxe,
        title: 'Haxe',
        type: :object,
        properties: {
          haxe: {
            '$ref': '#/definitions/strs'
          },
          hxml: {
            '$ref': '#/definitions/strs'
          },
          neko: {
            type: :string
          }
        },
        normal: true,
        only: {
          haxe: {
            language: [
              'haxe'
            ]
          },
          hxml: {
            language: [
              'haxe'
            ]
          },
          neko: {
            language: [
              'haxe'
            ]
          }
        }
      )
    end
  end

  describe 'schema' do
    subject { described_class.new.schema }

    it do
      should eq(
        '$ref': '#/definitions/language/haxe'
      )
    end
  end
end
