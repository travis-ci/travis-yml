describe Travis::Yml::Schema::Type::Str do
  let(:const) do
    Class.new(described_class) do
      def define
        default :one, only: { os: [:one] }
        default :two, only: { os: [:two] }
        strict false
        value :one, internal: true, only: { os: [:one] }
        value :two
      end
    end
  end

  subject { const.new }

  it { should have_opt defaults: [{ value: 'one', only: { os: ['one'] } }, { value: 'two', only: { os: ['two'] } }] }
  it { should have_opt strict: false }
  it { should have_opt enum: ['one', 'two'] }
  it { should have_opt values: { one: { flags: [:internal], only: { os: ['one'] } } } }

  describe 'values' do
    let(:node) { Class.new(described_class).new }

    before do
      node.value :one, internal: true
      node.value :one, aliases: [:uno]
    end

    it { expect(node.opts[:enum]).to eq ['one'] }
    it { expect(node.opts[:values]).to eq one: { aliases: ['uno'], flags: [:internal] } }
  end
end
