describe Travis::Yml::Schema::Type, 'expand' do
  let(:num) { described_class::Num.new }
  let(:str) { described_class::Str.new }
  let(:map) { described_class::Map.new }
  let(:seq) { described_class::Seq.new(nil, types: [map, str]) }
  let(:any) { described_class::Any.new(nil, types: [seq, num]) }

  subject { described_class.expand(any).map(&:to_h) }

  it do
    should eq [
      {
        type: :seq,
        types: [
          {
            type: :map,
            map: {}
          }
        ]
      },
      {
        type: :seq,
        types: [
          {
            type: :str,
          }
        ]
      },
      {
        type: :num
      }
    ]
  end
end
