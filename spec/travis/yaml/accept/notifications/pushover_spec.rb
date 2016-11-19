describe Travis::Yaml, 'notifications: pushover' do
  let(:msgs)     { subject.msgs }
  let(:pushover) { subject.to_h[:notifications][:pushover] }

  subject { described_class.apply(config) }

  describe 'given a hash' do
    let(:config) { { notifications: { pushover: { api_key: 'key', users: 'user' } } } }
    it { expect(pushover).to include(api_key: 'key', users: ['user']) }
  end

  describe 'given a hash with an unknown template var' do
    let(:config) { { notifications: { pushover: { api_key: 'key', template: ['%{wat}'] } } } }
    it { expect(pushover[:template]).to be_nil }
    it { expect(msgs).to include [:error, :'notifications.pushover', :unknown_var, 'unknown template variable "wat"'] }
  end

  describe 'callbacks' do
    %w(on_success on_failure).each do |callback|
      describe callback do
        %w(always never change).each do |value|
          describe 'accepts %p' % value do
            let(:config) { { notifications: { pushover: { callback.to_sym => value } } } }
            it { expect(pushover[callback.to_sym]).to eq value }
          end
        end
      end

      describe "inherits shared #{callback}" do
        %w(always never change).each do |value|
          describe 'accepts %p' % value do
            let(:config) { { notifications: { pushover: { api_key: 'api_key' }, callback.to_sym => value } } }
            it { expect(pushover[callback.to_sym]).to eq value }
          end
        end
      end
    end
  end
end
