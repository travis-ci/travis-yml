describe Travis::Yaml::Spec::Def::Deploy::ChefSupermarket do
  let(:spec) { described_class.new.spec }

  it do
    expect(except(spec, :map)).to eq(
      name: :chef_supermarket,
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
      user_id: {
        key: :user_id,
        types: [
          {
            type: :scalar,
            cast: [
              :secure
            ]
          }
        ]
      },
      client_key: {
        key: :client_key,
        types: [
          {
            type: :scalar,
            cast: [
              :secure
            ]
          }
        ]
      },
      cookbook_category: {
        key: :cookbook_category,
        types: [
          {
            type: :scalar
          }
        ]
      }
    )
  end
end
