describe Travis::Yaml::Doc::Spec::Map do
  let(:spec) { Travis::Yaml.expanded }

  describe 'keys' do
    it { expect(spec.keys).to include :language, :addons, :rvm, :python }
  end

  describe 'aliases' do
    it do
      expect(spec.aliases).to eq(
        language:      [:lang],
        branches:      [:branch],
        node_js:       [:javascript, :js, :node, :nodejs],
        rvm:           [:ruby],
        after_failure: [:on_failure],
        after_success: [:on_success],
        bioc_required: [:use_bioc],
      )
    end
  end

  describe 'required' do
    it { expect(spec.required.map(&:key)).to eq [:language, :os, :dist, :sudo] }
  end

  describe 'required_keys' do
    it { expect(spec.required_keys).to eq [:language, :os, :dist, :sudo] }
  end

  describe 'all_keys' do
    it { expect(spec.all_keys).to include :language, :apt, :packages, :provider }
  end

  describe 'down_keys' do
    let(:keys) { spec.down_keys }
    it { expect(keys[:provider]).to eq [:deploy] }
    it { expect(keys[:matrix]).to   be_nil }
  end
end
