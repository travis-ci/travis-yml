describe Travis::Yaml::Spec::Def::Root do
  let(:spec) { described_class.new.spec }
  let(:map)  { spec[:map] }

  let(:expand) do
    %i(
      jdk crystal dotnet mono solution d dart elixir otp_release elm go hhvm php ghc haxe
      julia node_js rvm gemfile xcode_scheme xcode_sdk perl perl6 python r
      rust scala smalltalk os arch env compiler
    )
  end

  let(:keys) do
    %i(
      version language os arch dist sudo env compiler matrix stages notifications
      stack conditions filter_secrets trace
    )
  end

  it do
    expect(except(spec, :map, :alias, :includes)).to eq(
      name: :root,
      type: :map,
      expand: expand,
      include: [:job, :support]
    )
  end

  it { expect(map.keys).to eq keys }

  it do
    expect(spec[:includes][:job][:map][:osx_image]).to eq(
      key: :osx_image,
      types: [
        type: :scalar,
        edge: true,
        only: {
          os: :osx
        }
      ]
    )
  end

  it do
    expect(spec[:includes][:job][:map][:source_key]).to eq(
      key: :source_key,
      types: [
        type: :scalar,
        secure: true
      ]
    )
  end
end
