describe Travis::Yml::Schema::Examples::Map do
  let(:const) do
    Class.new(Travis::Yml::Schema::Dsl::Map) {
      def define
        map :one, to: :str, eg: 'uno', required: true
        map :two, to: :str, eg: 'duo'
        map :three, to: Class.new(Travis::Yml::Schema::Dsl::Any) {
          def define
            add :seq, type: :str
            add :num
          end
        }
      end
    }
  end

  subject { described_class.new(transform(const.new.node)).examples }

  xit do
    should eq [
      { one: 'uno', two: 'string' },
      { one: 'uno', two: 1 },
      { one: 'uno', two: true },
    ]
  end
end
