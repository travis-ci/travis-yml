describe Travis::Yml::Schema::Examples::Any do
  subject { described_class.new(transform(const.new.node)).examples }

  describe 'archs' do
    let(:const) do
      Class.new(Travis::Yml::Schema::Dsl::Any) do
        def define
          arch = Class.new(Travis::Yml::Schema::Dsl::Enum) do
            def define
              values 'amd64', 'power'
            end
          end

          add :seq, type: arch
          add arch
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
      Class.new(Travis::Yml::Schema::Dsl::Seq) do
        def define
          type Class.new(Travis::Yml::Schema::Dsl::Map) {
            def define
              examples \
                name: 'job name',
                if: 'branch = master'

              prefix :name
              map :name, to: :str
              map :if, to: :str
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
