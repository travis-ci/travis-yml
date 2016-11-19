describe Travis::Yaml::Spec::Def::Deploy::Puppetforge do
  let(:spec) { described_class.new.spec }

  it do
    expect(except(spec, :map)).to eq(
      name: :puppetforge,
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
            required: true,
            cast: [
              :secure
            ]
          }
        ]
      },
      password: {
        key: :password,
        types: [
          {
            type: :scalar,
            required: true,
            cast: [
              :secure
            ]
          }
        ]
      },
      url: {
        key: :url,
        types: [
          {
            type: :scalar
          }
        ]
      }
    )
  end
end
