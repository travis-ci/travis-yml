describe Travis::Yaml::Spec::Def::Addons, 'sauce_connect' do
  let(:spec) { described_class.new.spec[:map][:sauce_connect] }

  it do
    expect(spec).to eq(
      key: :sauce_connect,
      types: [
        {
          name: :sauce_connect,
          type: :map,
          change: [
            {
              name: :enable
            }
          ],
          map: {
            enabled: {
              key: :enabled,
              types: [
                {
                  type: :scalar,
                  cast: :bool
                }
              ]
            },
            username: {
              key: :username,
              types: [
                {
                  type: :scalar,
                  secure: true,
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
            direct_domains: {
              key: :direct_domains,
              types: [
                {
                  type: :scalar
                }
              ]
            },
            tunnel_domains: {
              key: :tunnel_domains,
              types: [
                {
                  type: :scalar
                }
              ]
            },
            no_ssl_bump_domains: {
              key: :no_ssl_bump_domains,
              types: [
                {
                  type: :scalar
                }
              ]
            }
          }
        }
      ]
    )
  end
end
