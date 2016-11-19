describe Travis::Yaml::Spec::Def::Deploy::Appfog do
  let(:spec) { described_class.new.spec }

  it do
    expect(except(spec, :map)).to eq(
      name: :appfog,
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
      user: {
        key: :user,
        types: [
          {
            type: :scalar,
            cast: [
              :secure
            ]
          },
          {
            type: :map,
            cast: [
              :secure
            ],
            strict: false,
            map: {}
          }
        ]
      },
      password: {
        key: :password,
        types: [
          {
            type: :scalar,
            cast: [
              :secure
            ]
          },
          {
            type: :map,
            cast: [
              :secure
            ],
            strict: false,
            map: {}
          }
        ]
      },
      email: {
        key: :email,
        types: [
          {
            type: :scalar,
            cast: [
              :secure
            ]
          },
          {
            type: :map,
            cast: [
              :secure
            ],
            strict: false,
            map: {}
          }
        ]
      },
      api_key: {
        key: :api_key,
        types: [
          {
            type: :scalar,
            cast: [
              :secure
            ]
          },
          {
            type: :map,
            cast: [
              :secure
            ],
            strict: false,
            map: {}
          }
        ]
      },
      app: {
        key: :app,
        types: [
          {
            type: :scalar
          },
          {
            type: :map,
            strict: false,
            map: {}
          }
        ]
      },
      address: {
        key: :address,
        types: [
          {
            type: :seq,
            types: [
              {
                type: :scalar
              }
            ]
          }
        ]
      },
      metadata: {
        key: :metadata,
        types: [
          {
            type: :scalar
          }
        ]
      },
      after_deploy: {
        key: :after_deploy,
        types: [
          {
            type: :seq,
            types: [
              {
                type: :scalar
              }
            ]
          }
        ]
      }
    )
  end
end
