describe Travis::Yaml::Spec::Def::Deploy::Codedeploy do
  let(:spec) { described_class.new.spec }

  it do
    expect(except(spec, :map)).to eq(
      name: :codedeploy,
      type: :map,
      strict: false,
      prefix: {
        key: :provider,
        type: :scalar
      }
    )
  end

  it do
    expect(except(spec[:map], :provider, :on, :skip_cleanup, :edge)).to eq(
      access_key_id: {
        key: :access_key_id,
        types: [
          {
            type: :scalar,
            cast: [
              :secure
            ],
            alias: [
              "access-key-id"
            ]
          }
        ]
      },
      secret_access_key: {
        key: :secret_access_key,
        types: [
          {
            type: :scalar,
            cast: [
              :secure
            ],
            alias: [
              "secret-access-key"
            ]
          }
        ]
      },
      application: {
        key: :application,
        types: [
          {
            type: :scalar
          }
        ]
      },
      deployment_group: {
        key: :deployment_group,
        types: [
          {
            type: :scalar
          }
        ]
      },
      revision_type: {
        key: :revision_type,
        types: [
          {
            type: :fixed,
            values: [
              {
                value: "s3"
              },
              {
                value: "github"
              }
            ],
            ignore_case: true
          }
        ]
      },
      commit_id: {
        key: :commit_id,
        types: [
          {
            type: :scalar
          }
        ]
      },
      repository: {
        key: :repository,
        types: [
          {
            type: :scalar
          }
        ]
      },
      region: {
        key: :region,
        types: [
          {
            type: :scalar
          }
        ]
      },
      wait_until_deployed: {
        key: :wait_until_deployed,
        types: [
          {
            type: :scalar,
            cast: [
              :bool
            ],
            alias: [
              "wait-until-deployed"
            ]
          }
        ]
      },
      bucket: {
        key: :bucket,
        types: [
          {
            type: :scalar
          }
        ]
      },
      key: {
        key: :key,
        types: [
          {
            type: :scalar
          }
        ]
      }
    )
  end
end
