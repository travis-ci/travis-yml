describe Travis::Yml::Schema::Type::Any do
  let!(:one) do
    Class.new(Travis::Yml::Schema::Type::Node) do
      register :one
    end
  end

  let!(:two) do
    Class.new(Travis::Yml::Schema::Type::Node) do
      register :two
    end
  end

  let(:const) do
    Class.new(described_class) do
      def define
        title 'title'
        detect :provider
        types :one, :two
      end
    end
  end

  subject { const.new }

  it { should have_opt title: 'title' }
  it { should have_opt detect: :provider }
  it { expect(subject.types.map(&:class)).to eq [one, two] }
end
