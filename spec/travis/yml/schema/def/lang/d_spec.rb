describe Travis::Yml::Schema::Def::D, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:d] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :d,
        title: 'D',
        type: :object,
        properties: {
          d: {
            '$ref': '#/definitions/strs'
          }
        },
        keys: {
          d: {
            only: {
              language: [
                'd'
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
        '$ref': '#/definitions/language/d'
      )
    end
  end
end
