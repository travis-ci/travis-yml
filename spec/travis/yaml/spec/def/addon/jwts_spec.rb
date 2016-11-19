describe Travis::Yaml::Spec::Def::Addons, 'jwts' do
  let(:spec) { described_class.new.spec[:map][:jwt] }

  it do
    expect(spec).to eq(
      key: :jwt,
      types: [
        {
          name: :jwts,
          type: :seq,
          types: [
            {
              type: :scalar,
              cast: :secure
            }
          ]
        }
      ]
    )
  end
end
