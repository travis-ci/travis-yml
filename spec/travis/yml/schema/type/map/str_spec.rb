describe Travis::Yml::Schema::Type::Map do
  let(:const) do
    Class.new(described_class) do
      def define
        map :other, to: :str, alias: :others, edge: true, default: 'default',
          strict: false, values: %w(one two), downcase: true, format: 'format',
          summary: 'summary', eg: 'example'
      end
    end
  end

  subject { const.new[:other] }

  it { should be_a Travis::Yml::Schema::Type::Str }
  it { should have_opt aliases: [:others] }
  it { should have_opt downcase: true }
  it { should have_opt flags: [:edge] }
  it { should have_opt defaults: [value: 'default'] }
  it { should have_opt format: 'format' }
  it { should have_opt strict: false }
  it { should have_opt enum: %w(one two) }
  it { should have_opt summary: 'summary' }
  it { should have_opt example: 'example' }
  it { should_not have_opt :values }
end
