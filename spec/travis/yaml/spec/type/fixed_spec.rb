describe Travis::Yaml::Spec::Type::Fixed do
  let(:type) do
    Class.new(described_class) do
      def define
        value :foo, :bar
        value :baz, alias: 'Baz'
      end
    end
  end

  it do
    expect(type.new.spec).to eq(
      name: nil,
      type: :fixed,
      values: [
        { value: 'foo' },
        { value: 'bar' },
        { value: 'baz', alias: ['Baz'] },
      ]
    )
  end
end
