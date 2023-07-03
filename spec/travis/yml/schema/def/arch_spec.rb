describe Travis::Yml::Schema::Def::Archs do
  describe 'archs' do
    subject { Travis::Yml.schema[:definitions][:type][:archs] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :archs,
        title: 'Architectures',
        summary: 'Build environment architectures',
        description: 'The architectures that will be selected for the build environments.',
        anyOf: [
          {
            type: :array,
            items: {
              '$ref': '#/definitions/type/arch',
            },
            normal: true,
          },
          {
            '$ref': '#/definitions/type/arch',
          }
        ],
      )
    end
  end

  describe 'arch' do
    subject { Travis::Yml.schema[:definitions][:type][:arch] }

    it do
      should eq(
        '$id': :arch,
        title: 'Architecture',
        summary: 'Build environment architecture',
        description: 'The architecture that will be selected for the build environment.',
        type: :string,
        enum: [
          'amd64',
          'arm64',
          'arm64-graviton2',
          'ppc64le',
          'i386',
          's390x',
        ],
        downcase: true,
        values: {
          amd64: {
            aliases: [
              'x86_64',
              'x64',
            ]
          },
          ppc64le: {
            aliases: [
              'power',
              'ppc',
              'ppc64'
            ]
          },
          i386: {
            aliases: [
              'x86'
            ]
          }
        }
      )
    end
  end
end
