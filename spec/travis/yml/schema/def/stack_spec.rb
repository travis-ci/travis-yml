describe Travis::Yml::Schema::Def::Stack, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:type][:stack] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :stack,
        title: 'Stack',
        type: :string,
        enum: [
          'connie',
          'amethyst',
          'garnet',
          'stevonnie',
          'opal',
          'sardonyx',
          'onion',
          'cookiecat'
        ],
        downcase: true,
        flags: [
          :edge
        ]
      )
    end
  end

  describe 'schema' do
    subject { described_class.new.schema }

    it do
      should eq(
        '$ref': '#/definitions/type/stack'
      )
    end
  end
end
