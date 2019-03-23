describe Travis::Yml::Doc::Validate, 'default', required: true, defaults: true do
  subject { Travis::Yml.apply(value, opts) }

  describe 'language, os, dist' do
    describe 'given a str' do
      let(:value) { { language: 'ruby' } }
      it { should serialize_to defaults }
      it { should_not have_msg [:info, :language, :default, default: 'ruby'] }
      it { should have_msg [:info, :os, :default, default: 'linux'] }
    end

    describe 'given an empty string' do
      let(:value) { { language: '' } }
      it { should serialize_to defaults }
      it { should have_msg [:info, :language, :default, default: 'ruby'] }
    end

    describe 'given nil' do
      let(:value) { { language: nil } }
      it { should serialize_to defaults }
      it { should have_msg [:info, :language, :default, default: 'ruby'] }
    end

    describe 'missing key' do
      let(:value) { {} }
      it { should serialize_to defaults }
      it { should have_msg [:info, :language, :default, default: 'ruby'] }
    end
  end

  describe 'addons.coverity_scan.project.name' do
    describe 'given a value' do
      let(:value) { defaults.merge(addons: { coverity_scan: { project: { name: 'name' } } }) }
      it { should serialize_to value }
      it { should_not have_msg }
    end

    describe 'given nil' do
      let(:value) { defaults.merge(addons: { coverity_scan: { project: { name: nil } } }) }
      it { should serialize_to defaults }
      it { should have_msg [:error, :'addons.coverity_scan.project', :required, key: :name] }
    end

    describe 'missing key' do
      let(:value) { defaults.merge(addons: { coverity_scan: { project: {} } }) }
      it { should serialize_to defaults }
      it { should have_msg [:error, :'addons.coverity_scan.project', :required, key: :name] }
    end
  end
end
