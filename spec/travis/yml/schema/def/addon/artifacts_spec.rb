describe Travis::Yml::Schema::Def::Addon::Artifacts do
  subject { Travis::Yml.schema[:definitions][:addon][:artifacts] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :addon_artifacts,
      title: 'Addon Artifacts',
      normal: true,
      anyOf: [
        {
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
              '$ref': '#/definitions/type/secure',
              aliases: [
                :aws_access_key_id,
                :aws_access_key,
                :access_key_id,
                :access_key
              ],
            },
            secret: {
              '$ref': '#/definitions/type/secure',
              aliases: [
                :aws_secret_access_key,
                :aws_secret_key,
                :secret_access_key,
                :secret_key,
              ],
            },
            paths: {
              '$ref': '#/definitions/type/strs'
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
