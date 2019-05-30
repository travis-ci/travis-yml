describe Travis::Yml::Schema::Type::Str do
  let(:const) do
    Class.new(described_class) do
      def define
        downcase
        format 'format'
        vars :one, :two
      end
    end
  end

  subject { const.new }

  it { should have_opt downcase: true }
  it { should have_opt format: 'format' }
  it { should have_opt vars: [:one, :two] }
end
