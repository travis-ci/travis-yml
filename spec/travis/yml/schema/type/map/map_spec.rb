describe Travis::Yml::Schema::Type::Map do
  let(:const) do
    Class.new(described_class) do
      def define
        map :key, to: :map, type: :str, strict: false, edge: true
      end
    end
  end

  subject { const.new[:key].to_h }

  it do
    should eq(
      type: :any,
      flags: [
        :edge
      ],
      types: [
        {
          type: :map,
          types: [
            type: :str
          ],
        },
        {
          type: :str
        }
      ]
    )
  end
end
