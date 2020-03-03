describe Travis::Yml::Schema::Def::Compilers do
  describe 'compilers' do
    subject { Travis::Yml.schema[:definitions][:type][:compilers] }

    # it { puts JSON.pretty_generate(subject[:compilers]) }

    it do
      should include(
        '$id': :compilers,
        title: 'Compilers',
        summary: kind_of(String),
        see: kind_of(Hash),
        anyOf: [
          {
            type: :array,
            items: {
              type: :string,
              example: 'gcc',
              only: {
                language: [
                  'c',
                  'cpp'
                ]
              }
            },
            normal: true,
          },
          {
            type: :string,
            example: 'gcc',
            only: {
              language: [
                'c',
                'cpp'
              ]
            }
          }
        ]
      )
    end
  end
end
