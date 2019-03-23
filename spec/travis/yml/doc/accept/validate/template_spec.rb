describe Travis::Yml, 'template' do
  subject { described_class.apply(value) }

  describe 'notifications.slack.template' do
    describe 'given a str' do
      let(:value) { { notifications: { slack: { template: ['str'] } } } }
      it { should serialize_to value }
      it { should_not have_msg }
    end

    describe 'given a known var' do
      let(:value) { { notifications: { slack: { template: ['%{repository}'] } } } }
      it { should serialize_to value }
      it { should_not have_msg }
    end

    describe 'given an unknown var' do
      let(:value) { { notifications: { slack: { template: ['%{unknown}'] } } } }
      it { should serialize_to value }
      it { should have_msg [:warn, :'notifications.slack.template', :unknown_var, var: 'unknown'] }
    end
  end
end
