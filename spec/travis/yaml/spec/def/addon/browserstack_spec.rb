describe Travis::Yaml::Spec::Def::Addons, 'browserstack' do
  let(:spec) { described_class.new.spec[:map][:browserstack] }

  it do
    expect(spec).to eq(
      key: :browserstack,
      types: [
        {
          name: :browserstack,
          type: :map,
          map: {
            username: {
              key: :username,
              types: [
                {
                  type: :scalar,
                  cast: :str
                }
              ]
            },
            access_key: {
              key: :access_key,
              types: [
                {
                  type: :scalar,
                  secure: true,
                }
              ]
            },
            forcelocal: {
              key: :forcelocal,
              types: [
                {
                  type: :scalar,
                  cast: :bool
                }
              ]
            },
            only: {
              key: :only,
              types: [
                {
                  type: :scalar
                }
              ]
            },
            proxyHost: {
              key: :proxyHost,
              types: [
                {
                  type: :scalar
                }
              ]
            },
            proxyPort: {
              key: :proxyPort,
              types: [
                {
                  type: :scalar
                }
              ]
            },
            proxyUser: {
              key: :proxyUser,
              types: [
                {
                  type: :scalar
                }
              ]
            },
            proxyPass: {
              key: :proxyPass,
              types: [
                {
                  type: :scalar,
                  secure: true,
                }
              ]
            }
          }
        }
      ]
    )
  end
end
