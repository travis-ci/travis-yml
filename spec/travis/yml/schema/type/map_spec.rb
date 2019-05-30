describe Travis::Yml::Schema::Type::Map do
  let!(:one) do
    Class.new(Travis::Yml::Schema::Type::Str) do
      register :one
    end
  end

  let(:const) do
    Class.new(described_class) do
      def define
        prefix :foo, only: { os: [:one] }
        strict false
        max_size 5
        types :one
        includes :one
      end
    end
  end

  let(:map) { const.new }

  after { one.unregister }

  subject { map }

  describe 'instance' do
    it { should have_opt strict: false }
    it { should have_opt max_size: 5 }
    it { should have_opt prefix: { key: :foo, only: { os: [:one] } } }
    it { expect(subject.types.map(&:class)).to eq [one] }
    it { expect(subject.includes.map(&:class)).to eq [one] }
  end

  describe 'map (shortcut)' do
    let(:const) do
      Class.new(described_class) do
        def define
          map :one, required: true, eg: 'example'
        end
      end
    end

    subject { map[:one] }

    it { should be_a one }
    it { should have_attributes key: :one }
    it { should have_opt example: 'example' }
    it { should_not have_opt :required }
    it { expect(map).to have_opt required: [:one] }
  end

  describe 'map' do
    let(:const) do
      Class.new(described_class) do
        def define
          map :uno, to: :one, alias: :one, summary: 'summary', eg: 'example',
            deprecated: 'deprecated', strict: false, values: ['one'], edge: true,
            default: 'default', internal: true, required: true
          map :duo, to: :str, required: true
        end
      end
    end

    subject { const.new[:uno] }

    it { should be_a one }
    it { should have_attributes key: :uno }
    it { should have_opt aliases: [:one] }
    it { should have_opt summary: 'summary' }
    it { should have_opt example: 'example' }
    it { should have_opt deprecated: 'deprecated' }
    it { should have_opt flags: [:edge, :internal] }
    it { should have_opt strict: false }
    it { should have_opt enum: ['one'] }
    it { should have_opt defaults: [{ value: 'default' }] }
    it { expect(map).to have_opt required: [:uno, :duo] }
  end

  describe 'matrix' do
    let(:const) do
      Class.new(described_class) do
        def define
          matrix :one
        end
      end
    end

    subject { const.new[:one] }

    it { should be_a one }
    it { should have_attributes key: :one }
    it { should have_opt flags: [:expand] }
    # it { expect(subject.root.expand_keys).to eq [:one] }
  end

  describe 'matrix (exported type)' do
    let!(:two) do
      Class.new(Travis::Yml::Schema::Type::Str) do
        register :two

        def define
          export
        end

        def id
          :two
        end
      end
    end

    let(:const) do
      Class.new(described_class) do
        def define
          matrix :two
        end
      end
    end

    after do
      two.unregister
      const.exports.delete(:'type/two')
    end

    subject { const.new[:two] }

    it { should be_a Travis::Yml::Schema::Type::Ref }
    it { should have_opt flags: [:expand] }
    # it { expect(subject.root.expand_keys).to eq [:two] }
  end

  describe 'includes' do
    let!(:two) do
      Class.new(Travis::Yml::Schema::Type::Map) do
        register :two

        def define
          map :two, to: :str
        end
      end
    end

    let(:one) do
      Class.new(described_class) do
        register :one

        def define
          map :one, to: :str
          includes :two
        end
      end
    end

    after { [one, two].each(&:unregister) }

    subject { one.build(:one).to_h }

    it do
      should eq(
        type: :all,
        types: [
          {
            type: :map,
            map: {
              one: {
                type: :str
              }
            }
          },
          {
            type: :map,
            map: {
              two: {
                type: :str
              }
            }
          }
        ]
      )
    end
  end

  describe 'inheritance' do
    let(:base) do
      Class.new(described_class) do
        def define
          prefix :foo
          strict false
          types :one
          includes :one
          export
        end
      end
    end

    let(:const) do
      Class.new(base) do
        def define
          max_size 5
          super
        end
      end
    end

    subject { const.new }

    it { should be_export }
    it { should have_opt prefix: { key: :foo } }
    it { should have_opt strict: false }
    it { should have_opt max_size: 5 }
    it { expect(subject.types.map(&:class)).to eq [one] }
    # it { expect(subject.includes.map(&:class)).to eq [one] }
  end
end
