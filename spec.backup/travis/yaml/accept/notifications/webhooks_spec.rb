describe Travis::Yaml, 'notifications: webhooks' do
  let(:webhooks) { subject.serialize[:notifications][:webhooks] }

  subject { described_class.apply(input) }

  describe 'given a string' do
    let(:input) { { notifications: { webhooks: 'url' } } }
    it { expect(webhooks).to include(urls: ['url']) }
  end

  describe 'given a secure' do
    let(:input) { { notifications: { webhooks: { secure: 'secure' } } } }
    it { expect(webhooks).to include(urls: [secure: 'secure']) }
  end

  describe 'given an array' do
    let(:input) { { notifications: { webhooks: ['url'] } } }
    it { expect(webhooks).to include(urls: ['url']) }
  end

  describe 'given a hash with a string' do
    let(:input) { { notifications: { webhooks: { urls: 'url' } } } }
    it { expect(webhooks).to include(urls: ['url']) }
  end

  describe 'given a hash with a secure' do
    let(:input) { { notifications: { webhooks: { urls: { secure: 'url' } } } } }
    it { expect(webhooks).to include(urls: [secure: 'url']) }
  end

  describe 'given a hash with an array' do
    let(:input) { { notifications: { webhooks: { urls: ['url'] } } } }
    it { expect(webhooks).to include(urls: ['url']) }
  end

  describe 'callbacks' do
    %w(on_success on_failure).each do |callback|
      describe callback do
        %w(always never change).each do |value|
          describe 'accepts %p' % value do
            let(:input) { { notifications: { webhooks: { callback.to_sym => value } } } }
            it { expect(webhooks[callback.to_sym]).to eq value }
          end
        end
      end

      describe "inherits shared #{callback}" do
        %w(always never change).each do |value|
          describe 'accepts %p' % value do
            let(:input) { { notifications: { webhooks: { urls: 'urls' }, callback.to_sym => value } } }
            it { expect(webhooks[callback.to_sym]).to eq value }
          end
        end
      end
    end
  end

  describe 'wat' do
    let(:input) { { env: [secure: 'secure'], notifications: { webhooks: { secure: 'secure' } } } }
    it { expect(msgs.select { |msg| msg[0] == :error }).to be_empty }
  end
end
