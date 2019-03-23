describe Travis::Yml::Schema::Def::Git, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:type][:git] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :git,
        title: 'Git',
        type: :object,
        properties: {
          strategy: {
            type: :string,
            enum: [
              'clone',
              'tarball'
            ]
          },
          quiet: {
            type: :boolean
          },
          depth: {
            type: :number
          },
          submodules: {
            type: :boolean
          },
          submodules_depth: {
            type: :number
          }
        },
        additionalProperties: false
      )
    end
  end

  describe 'schema' do
    subject { described_class.new.schema }

    it do
      should eq(
        '$ref': '#/definitions/type/git'
      )
    end
  end
end
