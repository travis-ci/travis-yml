describe Travis::Yml::Schema::Type::Map do
  let(:const) do
    Class.new(described_class) do
      def define
        map :other, to: :secure, strict: false, edge: true
      end
    end
  end

  subject { const.new[:other] }

  it { should be_a Travis::Yml::Schema::Type::Ref }
  it { should have_attributes ref: :'type/secure' }
  it { should have_opt strict: false }
  it { should have_opt flags: [:edge] }
end
