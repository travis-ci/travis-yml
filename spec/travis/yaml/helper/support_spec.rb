describe Travis::Yaml::Support do
  let(:spec)    { Travis::Yaml.spec[:includes][:support][:map] }
  let(:support) { described_class.new(spec, expand: true) }

  it do
    expect(support.map[:rvm]).to eq(
      key: :rvm,
      types: [
        type: :seq,
        expand: true,
        alias: ['ruby'],
        types: [
          type: :scalar
        ],
        only: {
          language: ['objective-c', 'ruby']
        },
        except: {
        }
      ]
    )
  end
end
