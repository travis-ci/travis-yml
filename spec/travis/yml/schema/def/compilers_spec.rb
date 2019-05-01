describe Travis::Yml::Schema::Def::Compilers do
  describe 'compilers' do
    subject { Travis::Yml.schema[:definitions][:type][:compilers] }

    # it { puts JSON.pretty_generate(subject[:compilers]) }

    it do
      should eq(
        '$id': :compilers,
        title: 'Compilers',
        flags: [
          :expand
        ],
        anyOf: [
          {
            type: :array,
            items: {
              type: :string,
              only: {
                language: [
                  'c',
                  'cpp'
                ]
              }
            },
            normal: true,
            flags: [
              :expand
            ]
          },
          {
            type: :string,
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
