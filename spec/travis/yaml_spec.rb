describe Travis::Yaml do
  describe 'spec' do
    let(:spec) { Travis::Yaml.spec }

    describe 'root' do
      it { expect(spec[:map].keys).to include :language }
      it { expect(spec[:map].keys).to_not include :rvm }
      it { expect(spec[:map].keys).to_not include :addons }
    end
  end

  describe 'load' do
    describe 'when passed \n' do
      let(:config) { Travis::Yaml.load("\n") }
      it { expect { config }.to_not raise_error }
    end
  end

  describe 'expanded' do
    let(:spec) { Travis::Yaml.expanded }

    describe 'root' do
      let(:node) { spec }
      it { expect(node.map.keys).to include :language }
      it { expect(node.map.keys).to include :rvm }
      it { expect(node.map.keys).to include :addons }
    end

    describe 'matrix_entry' do
      let(:node) { spec.map[:matrix].types[0].map[:include].types[0].types[0] }
      it { expect(node.map.keys).to include :language }
      it { expect(node.map.keys).to include :rvm }
      it { expect(node.map.keys).to include :addons }
    end

    describe 'deploy_condition' do
      let(:node) { spec.map[:deploy].types[0].types[1].map[:on].types.first }
      it { expect(node.map.keys).to include :branch }
      it { expect(node.map.keys).to include :rvm }
      it { expect(node.map.keys).to_not include :addons }
    end
  end

  describe 'msg' do
    subject { described_class.msg(msg) }

    describe 'alert' do
      let(:msg) { [:error, :key, :alert] }
      it { should eq '[error] on key: this string should probably be encrypted' }
    end

    describe 'alias' do
      let(:msg) { [:info, :key, :alias, alias: 'rvm', actual: 'ruby'] }
      it { should eq '[info] on key: rvm is an alias for ruby, using ruby' }
    end

    describe 'cast' do
      let(:msg) { [:info, :key, :cast, given_value: 'foo', given_type: :str, value: true, type: :bool] }
      it { should eq '[info] on key: casting value foo (:str) to true (:bool)' }
    end

    describe 'default' do
      let(:msg) { [:info, :key, :default, key: :key, default: 'default'] }
      it { should eq '[info] on key: missing :key, using the default default' }
    end

    describe 'deprecated' do
      let(:msg) { [:info, :key, :deprecated, given: :key, info: 'something'] }
      it { should eq '[info] on key: :key is deprecated' }
    end

    describe 'downcase' do
      let(:msg) { [:info, :key, :downcase, value: 'FOO'] }
      it { should eq '[info] on key: lowercasing FOO' }
    end

    describe 'edge' do
      let(:msg) { [:info, :key, :edge, given: :key] }
      it { should eq '[info] on key: :key is experimental and might be removed without notice' }
    end

    describe 'flagged' do
      let(:msg) { [:info, :key, :flagged, given: :key] }
      it { should eq '[info] on key: please email support@travis-ci.org to enable :key' }
    end

    describe 'irrelevant' do
      let(:msg) { [:info, :key, :irrelevant, on_key: :language, on_value: 'ruby', key: :key, value: 'value'] }
      it { should eq '[info] on key: you used :key, but it is not relevant for the :language ruby' }
    end

    describe 'unsupported' do
      let(:msg) { [:info, :key, :unsupported, on_key: :language, on_value: 'ruby', key: :key, value: 'value'] }
      it { should eq '[info] on key: :key (value) is not supported on the :language ruby' }
    end

    describe 'required' do
      let(:msg) { [:info, :key, :required, key: :key] }
      it { should eq '[info] on key: you need to specify :key' }
    end

    describe 'empty' do
      let(:msg) { [:info, :key, :empty, key: :key] }
      it { should eq '[info] on key: dropping empty section :key' }
    end

    describe 'unkown_key' do
      let(:msg) { [:info, :key, :unknown_key, key: :key, value: 'value'] }
      it { should eq '[info] on key: dropping unknown key :key (value)' }
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

    describe 'invalid_seq' do
      let(:msg) { [:info, :key, :invalid_seq, value: 'value'] }
      it { should eq '[info] on key: unexpected sequence, using the first value (value)' }
    end
  end
end
