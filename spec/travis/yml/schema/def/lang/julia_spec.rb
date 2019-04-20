describe Travis::Yml::Schema::Def::Julia, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:julia] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :julia,
        title: 'Julia',
        type: :object,
        properties: {
          julia: {
            '$ref': '#/definitions/strs'
          }
        },
        keys: {
          julia: {
            only: {
              language: [
                'julia'
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
        '$ref': '#/definitions/language/julia'
      )
    end
  end
end
