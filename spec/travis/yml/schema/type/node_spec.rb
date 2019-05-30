describe Travis::Yml::Schema::Type::Node do
  let(:const) do
    Class.new(described_class) do
      def define
        namespace 'namespace'
        id 'id'
        title 'title'
        description 'description'
        example 'example'
        deprecated 'deprecation'
        aliases :one, :two
        change :foo, one: [:one]
        change :bar
        edge
        expand
        internal
        supports :only, os: :linux
      end
    end
  end

  subject { const.new }

  it { should be_a const }
  it { should have_attr namespace: 'namespace' }
  it { should have_attr id: 'id' }
  it { should have_opt title: 'title' }
  it { should have_opt description: 'description' }
  it { should have_opt example: 'example' }
  it { should have_opt deprecated: 'deprecation' }
  it { should have_opt aliases: [:one, :two] }
  it { should have_opt changes: [{ change: :foo, one: [:one] }, { change: :bar }] }
  it { should have_opt flags: [:edge, :expand, :internal] }
  it { should have_opt only: { os: ['linux'] } }

  describe 'build (export)' do
    let(:const) do
      Class.new(described_class) do
        register :foo

        def define
          title 'defined title'
          export
        end

        def namespace
          :namespace
        end

        def id
          :id
        end
      end
    end

    after do
      const.unregister
      const.exports.delete(:'namespace/id')
    end

    let(:export) { const.exports[:'namespace/id'] }
    let!(:node)  { const.build(:foo, title: 'mapped title') }

    describe 'export' do
      subject { export }
      it { should be_a const }
      it { should have_opt title: 'defined title' }
    end

    describe 'node' do
      subject { node }
      it { should be_a Travis::Yml::Schema::Type::Ref }
      it { should have_opt title: 'mapped title' }
    end
  end

  describe 'build (caching)' do
    let(:const) do
      Class.new(described_class) do
        register :foo

        def self.name
          'Def::Foo'
        end
      end
    end

    before do
      allow(const).to receive(:new).and_call_original
      3.times { const.build(:foo) }
    end

    it { expect(const).to have_received(:new).once }
    it { expect(const.cache[:'type.foo']).to be_a const }
  end

  describe 'shapeshift' do
    subject { const.new.shapeshift(:str) }

    it { should have_opt title: 'title' }
    it { should have_attr namespace: 'namespace' }
    it { should have_attr id: 'id' }
    it { should have_opt title: 'title' }
    it { should have_opt description: 'description' }
    it { should have_opt example: 'example' }
    it { should have_opt deprecated: 'deprecation' }
    it { should have_opt aliases: [:one, :two] }
    it { should have_opt changes: [{ change: :foo, one: [:one] }, { change: :bar }] }
    it { should have_opt flags: [:edge, :expand, :internal] }
    it { should have_opt only: { os: ['linux'] } }
  end
end
