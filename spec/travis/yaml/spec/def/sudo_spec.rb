describe Travis::Yaml::Spec::Def::Sudo do
  let(:spec) { described_class.new.spec }

  it do
    expect(spec).to eq(
      name: :sudo,
      type: :scalar,
      normalize: [
        { name: :required }
      ],
      required: true,
      defaults: [
        { value: false }
      ],
      cast: [
        :bool
      ]
    )
  end
end
