describe Travis::Yaml::Doc::Spec::Seq do
  let(:spec) { Travis::Yaml.expanded[:deploy].types.first }

  describe 'required_keys' do
    it { expect(spec.required_keys).to include :provider }
  end

  describe 'all_keys' do
    it { expect(spec.all_keys).to include :provider, :on, :branch }
  end
end
