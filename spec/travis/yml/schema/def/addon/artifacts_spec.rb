describe Travis::Yml::Schema::Def::Addon::Artifacts, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:addon][:artifacts] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :artifacts,
        title: 'Artifacts',
        type: :object,
        properties: {
          enabled: {
            type: :boolean
          },
          bucket: {
            type: :string
          },
          endpoint: {
            type: :string
          },
          key: {
            '$ref': '#/definitions/secure'
          },
          secret: {
            '$ref': '#/definitions/secure'
          },
          paths: {
            '$ref': '#/definitions/strs'
          },
          branch: {
            type: :string
          },
          log_format: {
            type: :string
          },
          target_paths: {
            '$ref': '#/definitions/strs'
          },
          debug: {
            type: :boolean
          },
          concurrency: {
            type: :number
          },
          max_size: {
            type: :number
          },
          region: {
            type: :string
          },
          permissions: {
            type: :string
          },
          working_dir: {
            type: :string
          },
          cache_control: {
            type: :string
          }
        },
        additionalProperties: false,
        normal: true,
        keys: {
          key: {
            aliases: [
              :aws_access_key,
              :access_key
            ],
          },
          secret: {
            aliases: [
              :secret_key,
              :secret_access_key,
              :aws_secret,
              :aws_secret_key,
              :aws_secret_access_key
            ],
          },
          region: {
            aliases: [
              :s3_region
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
        '$ref': '#/definitions/addon/artifacts'
      )
    end
  end
end

