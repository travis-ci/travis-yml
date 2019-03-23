describe Travis::Yml::Schema::Def::Go, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:go] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :go,
        title: 'Go',
        type: :object,
        properties: {
          go: {
            '$ref': '#/definitions/strs'
          },
          gobuild_args: {
            type: :string
          },
          go_import_path: {
            type: :string
          },
          gimme_config: {
            type: :object,
            properties: {
              url: {
                type: :string
              },
              force_reinstall: {
                type: :boolean
              }
            },
            additionalProperties: false
          }
        },
        normal: true,
        only: {
          go: {
            language: [
              'go'
            ]
          },
          gobuild_args: {
            language: [
              'go'
            ]
          },
          go_import_path: {
            language: [
              'go'
            ]
          },
          gimme_config: {
            language: [
              'go'
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
        '$ref': '#/definitions/language/go'
      )
    end
  end
end
