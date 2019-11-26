describe Travis::Yml do
  describe 'schema' do
    let(:schema) { described_class.schema }

    describe 'root' do
      it { expect(schema.keys).to include :title }
      it { expect(schema.keys).to include :definitions }
      it { expect(schema.keys).to include :allOf }
    end
  end

  describe 'load' do
    describe 'when passed \n' do
      let(:config) { described_class.load("\n") }
      it { expect { config }.to_not raise_error }
    end
  end

  describe 'expand_keys' do
    it do
      expect(described_class.expand_keys).to eq %i(
        arch
        compiler
        crystal
        d
        dart
        dart_task
        dotnet
        elixir
        elm
        gemfile
        ghc
        go
        haxe
        hhvm
        jdk
        jobs
        julia
        mono
        nix
        node_js
        os
        osx_image
        otp_release
        perl
        perl6
        php
        python
        r
        rust
        rvm
        scala
        smalltalk
        smalltalk_config
        smalltalk_vm
        solution
        xcode_scheme
        xcode_sdk
      )
    end
  end

  describe 'matrix' do
    let(:matrix) { described_class.matrix(rvm: ['2.2', '2.3']) }

    describe 'rows' do
      subject { matrix.rows }
      xit { should eq [{ rvm: '2.2' }, { rvm: '2.3' }] }
    end

    describe 'rows' do
      subject { matrix.axes }
      xit { should eq [:rvm] }
    end
  end

  describe 'expand' do
    let(:schema) { described_class.expand }

    describe 'root' do
      let(:node) { schema }
      it { expect(node.keys).to include 'language' }
      it { expect(node.keys).to include 'rvm' }
      it { expect(node.keys).to include 'addons' }
    end

    describe 'jobs_entry' do
      let(:node) { schema.map['jobs'][0]['include'][0].schema }
      it { expect(node.keys).to include 'language' }
      it { expect(node.keys).to include 'rvm' }
      it { expect(node.keys).to include 'addons' }
    end

    describe 'deploy_condition' do
      let(:node) { schema.map['deploy'][0].schema[0][0]['on'][0] }
      it { expect(node.keys).to include 'branch' }
      it { expect(node.keys).to include 'rvm' }
      it { expect(node.keys).to_not include 'addons' }
    end
  end

  describe 'msg' do
    subject { described_class.msg(msg) }

    describe 'alias_key' do
      let(:msg) { [:info, :key, :alias_key, alias: 'rvm', key: 'ruby'] }
      it { should eq '[info] on key: the key rvm is an alias for ruby, using ruby' }
    end

    describe 'alias_value' do
      let(:msg) { [:info, :key, :alias_value, alias: 'rvm', value: 'ruby'] }
      it { should eq '[info] on key: the value rvm is an alias for ruby, using ruby' }
    end

    describe 'default' do
      let(:msg) { [:info, :key, :default, key: :key, default: 'default'] }
      it { should eq '[info] on key: missing key, using the default "default"' }
    end

    describe 'deprecated_key' do
      let(:msg) { [:info, :key, :deprecated_key, key: :other, info: 'something'] }
      it { should eq '[info] on key: deprecated key: :other (something)' }
    end

    describe 'deprecated_value' do
      let(:msg) { [:info, :key, :deprecated_value, value: :str, info: 'something'] }
      it { should eq '[info] on key: deprecated value: :str (something)' }
    end

    describe 'downcase' do
      let(:msg) { [:info, :key, :downcase, value: 'FOO'] }
      it { should eq '[info] on key: using lower case of FOO' }
    end

    describe 'edge' do
      let(:msg) { [:info, :key, :edge, given: :key] }
      it { should eq '[info] on key: this key is experimental and might change or be removed' }
    end

    describe 'flagged' do
      let(:msg) { [:info, :key, :flagged, key: :key] }
      it { should eq '[info] on key: please email support@travis-ci.com to enable :key' }
    end

    describe 'unsupported' do
      let(:msg) { [:info, :key, :unsupported, on_key: :language, on_value: 'ruby', key: :key, value: 'value'] }
      it { should eq '[info] on key: :key (value) is not supported on the :language ruby' }
    end

    describe 'required' do
      let(:msg) { [:info, :key, :required, key: :key] }
      it { should eq '[info] on key: missing required key :key' }
    end

    describe 'secure' do
      let(:msg) { [:error, :key, :secure] }
      it { should eq '[error] on key: expected an encrypted string' }
    end

    describe 'empty' do
      let(:msg) { [:info, :key, :empty, key: :key] }
      it { should eq '[info] on key: dropping empty section :key' }
    end

    describe 'unexpected_seq' do
      let(:msg) { [:info, :key, :unexpected_seq, value: 'value'] }
      it { should eq '[info] on key: unexpected sequence, using the first value (value)' }
    end

    describe 'unkown_key' do
      let(:msg) { [:info, :key, :unknown_key, key: :key, value: 'value'] }
      it { should eq '[info] on key: unknown key :key (value)' }
    end

    describe 'unknown_value' do
      let(:msg) { [:info, :key, :unknown_value, value: 'value'] }
      it { should eq '[info] on key: dropping unknown value: value' }
    end

    describe 'unknown_default' do
      let(:msg) { [:info, :key, :unknown_default, value: 'value', default: 'default'] }
      it { should eq '[info] on key: dropping unknown value: value, defaulting to default' }
    end

    describe 'unknown_var' do
      let(:msg) { [:info, :key, :unknown_var, var: :var] }
      it { should eq '[info] on key: unknown template variable :var' }
    end

    describe 'invalid_type' do
      let(:msg) { [:info, :key, :invalid_type, actual: :seq, expected: :map, value: 'value'] }
      it { should eq '[info] on key: dropping unexpected :seq, expected :map (value)' }
    end

    describe 'invalid_format' do
      let(:msg) { [:info, :key, :invalid_format, value: 'value'] }
      it { should eq '[info] on key: dropping invalid format value' }
    end

    describe 'key error' do
      let(:msg) { [:info, :key, :unknown_value, foo: :bar] }
      it { should eq 'unable to generate message (level: info, key: key, code: unknown_value, args: {:foo=>:bar})' }
    end
  end

  describe 'memoized methods on Obj subclasses' do
    let(:const) do
      Obj.new do
        def count
          @count ||= 0
          @count += 1
        end
        memoize :count

        prepend Module.new {
          attr_reader :called

          def count
            @called ||= 0
            @called += 1
            super
          end
        }
      end
    end

    let(:obj) { const.new }

    before { 10.times { obj.count } }

    it { expect(obj.count).to eq 1 }
    it { expect(obj.called).to eq 10 }
  end
end
