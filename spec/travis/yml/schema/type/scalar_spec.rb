describe Travis::Yml::Schema::Type::Str do
  let(:const) do
    Class.new(described_class) do
      def define
        default :one, only: { os: [:one] }
        default :two, only: { os: [:two] }
        strict false
        value :one, only: { os: [:one] }
        value :two
      end
    end
  end

  subject { const.new }

  it { should have_opt defaults: [{ value: 'one', only: { os: ['one'] } }, { value: 'two', only: { os: ['two'] } }] }
  it { should have_opt strict: false }
  it { should have_opt enum: ['one', 'two'] }
  it { should have_opt values: { one: { only: { os: ['one'] } } } }
end
