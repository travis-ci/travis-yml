describe Travis::Yml::Schema::Dsl::Node do
  let(:dsl) { Class.new(described_class).new }

  subject { dsl.node}

  describe 'caching' do
    let(:const) do
      Class.new(described_class[:str]) do
        register :foo

        def define
          edge
          export
        end
      end
    end

    # it do
    #   puts Travis::Yml::Schema::Type::Node.exports[:foo].dump
    # end
  end

  describe 'changes' do
    describe 'given a strs' do
      before { dsl.change :one, :two }
      it { should have_opts changes: [{ change: :one }, { change: :two }] }
    end

    describe 'given a str and opts' do
      before { dsl.change :one, foo: :bar }
      it { should have_opts changes: [{ change: :one, foo: :bar }] }
    end
  end

  describe 'export' do
    before { dsl.export }
    it { should be_export }
  end

  describe 'edge' do
    before { dsl.edge }
    it { should have_opts flags: [:edge] }
  end

  describe 'internal' do
    before { dsl.internal }
    it { should have_opts flags: [:internal] }
  end

  describe 'normal' do
    before { dsl.normal }
    it { should have_opts normal: true }
  end

  describe 'required' do
    before { dsl.required }
    xit { should be_required }
    xit { should_not have_opts }
  end

  describe 'unique' do
    before { dsl.unique }
    xit { should be_unique }
    xit { should_not have_opts }
  end

  describe 'only' do
    before { dsl.supports :only, os: 'linux' }
    it { should_not have_opts }
    it { expect(dsl.node.support).to eq only: { os: ['linux'] } }
  end
end
