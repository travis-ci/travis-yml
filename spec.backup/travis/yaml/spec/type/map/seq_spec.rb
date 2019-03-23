describe Travis::Yaml::Spec, 'mapping a scalar' do
  let(:type) do
    Class.new(described_class::Type::Map) do
      def define
        map :foo, to: :seq #, types: [type: :fixed, values: ['foo']] # TODO
      end
    end
  end

  it do
    expect(type.new.spec).to eq(
      type: :map,
      map: {
        foo: {
          key: :foo,
          types: [
            type: :seq,
            types: [
              {
                type: :scalar,
              }
            ]
          ]
        }
      }
    )
  end
end

