describe Travis::Yml::Schema::Examples::Map do
  let(:const) do
    Class.new(Travis::Yml::Schema::Dsl::Map) {
      def define
        examples \
          one: 'Uno',
          two: 'Duo'

        map :one, to: :str, required: true
        map :two, to: :str
        map :three, to: Class.new(Travis::Yml::Schema::Dsl::Any) {
          def define
            add :seq, type: :str
            add :num
          end
        }
      end
    }
  end

  subject { described_class.new(expand(const.new.node)).examples }

  it do
    should eq [
      { one: 'Uno', two: 'string' },
      { one: 'Uno', two: 1 },
      { one: 'Uno', two: true },
    ]
  end
end
