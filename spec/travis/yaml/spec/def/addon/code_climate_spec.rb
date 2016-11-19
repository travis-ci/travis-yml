describe Travis::Yaml::Spec::Def::Addons, 'code_climate' do
  let(:spec) { described_class.new.spec[:map][:code_climate] }

  it do
    expect(spec).to eq(
      key: :code_climate,
      types: [
        {
          name: :code_climate,
          type: :map,
          map: {
            repo_token: {
              key: :repo_token,
              types: [
                {
                  type: :scalar,
                  cast: [
                    :secure
                  ]
                }
              ]
            }
          }
        }
      ]
    )
  end
end
