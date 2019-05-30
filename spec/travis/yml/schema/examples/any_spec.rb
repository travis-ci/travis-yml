describe Travis::Yml::Schema::Examples::Any do
  let(:node) { Travis::Yml::Schema::Type::Node.build(const) }
  subject { described_class.new(node).examples }

  describe 'archs' do
    let(:const) do
      Class.new(Travis::Yml::Schema::Type::Seq) do
        def define
          type :str, values: ['amd64', 'power']
        end
      end
    end

    it do
      should eq(
        [
          ['amd64', 'power'],
          'amd64'
        ]
      )
    end
  end

  describe 'stages' do
    let(:const) do
      Class.new(Travis::Yml::Schema::Type::Seq) do
        def define
          type Class.new(Travis::Yml::Schema::Type::Map) {
            def define
              prefix :name
              map :name, to: :str, eg: 'job name'
              map :if, to: :str, eg: 'branch = master'
            end
          }
        end
      end
    end

    xit do
      should eq(
        [
          [{ name: 'job name', if: 'branch = master' }],
          { name: 'job name', if: 'branch = master' },
          ['job name one', 'job name two'],
          'job name'
        ]
      )
    end
  end
end
