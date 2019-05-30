describe Travis::Yml::Schema::Def::Groovy do
  subject { Travis::Yml.schema[:definitions][:language][:groovy] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
    '$id': :groovy,
      title: 'Groovy',
      type: :object,
      properties: {
        jdk: {
          '$ref': '#/definitions/type/jdks',
          flags: [
            :expand
          ],
          only: {
            language: [
              'groovy'
            ]
          },
        }
      },
      normal: true
    )
  end
end
