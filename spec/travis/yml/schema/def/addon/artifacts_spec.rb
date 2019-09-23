describe Travis::Yml::Schema::Def::Addon::Artifacts do
  subject { except(Travis::Yml.schema[:definitions][:addon][:artifacts], :description) }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should include(
      '$id': :artifacts,
      title: 'Artifacts',
      summary: instance_of(String),
      see: instance_of(Hash),
      normal: true,
      anyOf: [
        {
          type: :object,
          properties: {
            enabled: {
              type: :boolean,
              summary: 'Enable or disable uploading artifacts'
            },
            bucket: {
              type: :string,
              summary: 'The S3 bucket to upload to'
            },
            endpoint: {
              type: :string,
              summary: 'The S3 compatible endpoint to upload to'
            },
            key: {
              '$ref': '#/definitions/type/secure',
              summary: 'The S3 access key id',
              aliases: [
                :aws_access_key_id,
                :aws_access_key,
                :access_key_id,
                :access_key
              ],
              strict: false,
            },
            secret: {
              '$ref': '#/definitions/type/secure',
              summary: 'The S3 secret access key',
              aliases: [
                :aws_secret_access_key,
                :aws_secret_key,
                :secret_access_key,
                :secret_key,
              ],
            },
            paths: {
              '$ref': '#/definitions/type/strs',
              summary: 'Paths to the files to upload'
            },
            branch: {
              type: :string
            },
            log_format: {
              type: :string
            },
            target_paths: {
              '$ref': '#/definitions/type/strs'
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
              type: :string,
              summary: 'The S3 region',
              aliases: [
                :s3_region
              ]
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
          changes: [
            {
              change: :enable
            }
          ],
          normal: true,
        },
        {
          type: :boolean
        }
      ]
    )
  end
end
