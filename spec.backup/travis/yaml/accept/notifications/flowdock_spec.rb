describe Travis::Yaml, 'notifications: flowdock' do
  let(:flowdock) { subject.serialize[:notifications][:flowdock] }

  subject { described_class.apply(config) }

  describe 'given a string' do
    let(:config) { { notifications: { flowdock: 'token' } } }
    it { expect(flowdock).to eq api_token: 'token', enabled: true }
  end

  describe 'given a hash with an unknown template var' do
    let(:config) { { notifications: { flowdock: { api_token: 'token', template: ['%{wat}'] } } } }
    it { expect(flowdock[:template]).to be_nil }
    it { expect(msgs).to include [:error, :'notifications.flowdock.template', :unknown_var, var: 'wat'] }
  end

  describe 'callbacks' do
    %w(on_success on_failure).each do |callback|
      describe callback do
        %w(always never change).each do |value|
          describe 'accepts %p' % value do
            let(:config) { { notifications: { flowdock: { callback.to_sym => value } } } }
            it { expect(flowdock[callback.to_sym]).to eq value }
          end
        end
      end

      describe "inherits shared #{callback}" do
        %w(always never change).each do |value|
          describe 'accepts %p' % value do
            let(:config) { { notifications: { flowdock: { api_token: 'api_token' }, callback.to_sym => value } } }
            it { expect(flowdock[callback.to_sym]).to eq value }
          end
        end
      end
    end
  end
end
